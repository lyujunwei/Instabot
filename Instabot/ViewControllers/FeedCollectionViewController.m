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

@end
