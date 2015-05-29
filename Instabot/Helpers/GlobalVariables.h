//
//  GlobalVariables.h
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVariables.h"
#import "InstagramLoginResponse.h"

@interface GlobalVariables : NSObject

@property (nonatomic, assign) BOOL isLogin;

+ (GlobalVariables *)sharedInstance;

+ (void)saveUserInfo:(InstagramLoginResponse *)user;

+ (BOOL)loadUserInfo;

+ (InstagramLoginResponse *)getInstagramUserInfo;

@end
