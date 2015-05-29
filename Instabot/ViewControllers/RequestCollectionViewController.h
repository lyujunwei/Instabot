//
//  RequestCollectionViewController.h
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestCollectionViewController : UICollectionViewController

@property (nonatomic, strong) InstagramLoginResponse *loginResponse;
@property (nonatomic, strong) Pagination *pagination;
@property (nonatomic, strong) NSMutableArray *items;

- (void)startRefreshing:(InstagramLoginResponse *)response;
- (void)loadingMore:(InstagramLoginResponse *)response;

@end
