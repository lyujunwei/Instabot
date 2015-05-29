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
    self.loginResponse = [GlobalVariables getInstagramUserInfo];
    [self startRefreshing:self.loginResponse];
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
    self.loginResponse = response;
    self.items = [NSMutableArray new];
    __weak typeof(self) weakSelf = self;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[NSString stringWithFormat:@"%@", response.accessToken] forKey:@"access_token"];

    [manager GET:[NSString stringWithFormat:@"%@%@",InstagramAPI,USER_FEED] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary* jsonData = responseObject;

        self.pagination = [[Pagination alloc]initWithDict:[jsonData valueForKey:@"pagination"]];
        for (NSDictionary *info in [jsonData valueForKey:@"data"]) {
            UserDataModule *user =  [[UserDataModule alloc] initWithDict:info];
            [weakSelf.items addObject:user];
        }
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.collectionView.header endRefreshing];
    }];
}

- (void)loadingMore:(InstagramLoginResponse *)response
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.pagination.next_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary* jsonData = responseObject;
        self.pagination = [[Pagination alloc]initWithDict:[jsonData valueForKey:@"pagination"]];
        for (NSDictionary *info in [jsonData valueForKey:@"data"]) {
            UserDataModule *user =  [[UserDataModule alloc] initWithDict:info];
            [weakSelf.items addObject:user];
        }
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.collectionView.footer endRefreshing];
    }];
}

@end
