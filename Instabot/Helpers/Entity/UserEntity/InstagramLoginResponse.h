//
//  InstagramLoginResponse.h
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramUser.h"

@interface InstagramLoginResponse : NSObject

@property (copy, nonatomic, readonly) NSString *accessToken;
@property (strong, nonatomic, readonly) InstagramUser *user;

- (instancetype)initWithInstagramOAuthResponse:(NSDictionary *)response;

@end
