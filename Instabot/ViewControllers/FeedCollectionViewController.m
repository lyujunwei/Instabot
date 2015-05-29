//
//  FeedCollectionViewController.m
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "FeedCollectionViewController.h"
#import "FeedCollectionViewCell.h"

@interface FeedCollectionViewController ()

@end

@implementation FeedCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![GlobalVariables loadUserInfo]) {
        [self needLoginBtnPressed];
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FeedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    _loginResponse = [GlobalVariables getInstagramUserInfo];
    [self startRefreshing:_loginResponse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)needLoginBtnPressed
{
    LoginViewController *viewController = [[LoginViewController alloc] initWithClientID:CLIENT_ID
                                                                           clientSecret:CLIENT_SECRET
                                                                            callbackURL:[NSURL URLWithString:REDIRECT_URI]
                                                                             completion:^(InstagramLoginResponse *response, NSError *error) {
                                                                                 if (response.accessToken) {
                                                                                     [GlobalVariables saveUserInfo:response];
                                                                                     [self startRefreshing:response];
                                                                                     [viewController dismissViewControllerAnimated:YES completion:nil];
                                                                                 }
                                                                             }];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)startRefreshing:(InstagramLoginResponse *)response
{
    _loginResponse = response;
    _items = [NSMutableArray new];
    self.title = response.user.username;
    __weak typeof(self) weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[NSString stringWithFormat:@"%@", response.accessToken] forKey:@"access_token"];
    
    [manager GET:[NSString stringWithFormat:@"%@%@",InstagramAPI,USER_FEED] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary* jsonData = responseObject;
        
        _pagination = [[Pagination alloc]initWithDict:[jsonData valueForKey:@"pagination"]];
        for (NSDictionary *info in [jsonData valueForKey:@"data"]) {
            UserDataModule *user =  [[UserDataModule alloc] initWithDict:info];
            [weakSelf.items addObject:user];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)loadingMore:(InstagramLoginResponse *)response
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:_pagination.next_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary* jsonData = responseObject;
        _pagination = [[Pagination alloc]initWithDict:[jsonData valueForKey:@"pagination"]];
        for (NSDictionary *info in [jsonData valueForKey:@"data"]) {
            UserDataModule *user =  [[UserDataModule alloc] initWithDict:info];
            [weakSelf.items addObject:user];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"Cell";
    FeedCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateCollectionCellWith:_items[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(172, 172);
}

@end
