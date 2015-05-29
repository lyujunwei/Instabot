//
//  InstagramLoginManager.h
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramLoginResponse.h"
#import "InstagramLoginManager.h"

@interface InstagramLoginManager : NSObject

@property (copy, nonatomic, readonly) NSString *clientID;
@property (copy, nonatomic, readonly) NSString *clientSecret;
@property (strong, nonatomic, readonly) NSURL *callbackURL;

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     callbackURL:(NSURL *)callbackURL;

- (void)authenticateWithAuthCode:(NSString *)authCode
                         success:(void (^)(InstagramLoginResponse *instagramLoginResponse))success
                         failure:(void (^)(NSError *error))failure;

@end
