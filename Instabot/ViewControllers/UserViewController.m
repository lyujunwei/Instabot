//
//  UserViewController.m
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "UserViewController.h"
#import "FeedCollectionViewCell.h"
@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _loginResponse = [GlobalVariables getInstagramUserInfo];
    self.title = _loginResponse.user.username;
    [self startRefreshing:_loginResponse];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FeedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [manager GET:[NSString stringWithFormat:@"%@%@%@/media/recent/?",InstagramAPI,USER_RECENT,response.user.userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reuseIdentifier = @"Cell";
    FeedCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateCollectionCellWith:_items[indexPath.row]];
    return cell;
}

#pragma DelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(172, 172);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"index.section -> %ld , index.row -> %ld",indexPath.section,(long)indexPath.row);
}

@end
