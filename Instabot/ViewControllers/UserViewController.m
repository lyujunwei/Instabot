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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginResponse = [GlobalVariables getInstagramUserInfo];
    self.title = self.loginResponse.user.username;
    [self startRefreshing:self.loginResponse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRefreshing:(InstagramLoginResponse *)response
{
    self.loginResponse = response;
    __weak typeof(self) weakSelf = self;
    self.items = [NSMutableArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[NSString stringWithFormat:@"%@", response.accessToken] forKey:@"access_token"];
    
    [manager GET:[NSString stringWithFormat:@"%@%@%@/media/recent/?",InstagramAPI,USER_RECENT,response.user.userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"index.section -> %ld , index.row -> %ld",indexPath.section,(long)indexPath.row);
}

@end
