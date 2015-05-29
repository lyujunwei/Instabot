//
//  FeedCollectionViewController.h
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) InstagramLoginResponse *loginResponse;
@property (nonatomic, strong) Pagination *pagination;

@end
