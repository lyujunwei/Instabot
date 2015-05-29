//
//  InstagramLoginUtils.h
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramLoginUtils : NSObject

@property (copy, nonatomic, readonly) NSString *clientID;
@property (strong, nonatomic, readonly) NSURL *callbackURL;

- (instancetype)initWithClientID:(NSString *)clientID
                  andCallbackURL:(NSURL *)callbackURL;

- (NSURLRequest *)buildLoginRequestWithPermissionScope:(NSArray *)permissionScope;

- (BOOL)requestHasAuthCode:(NSURLRequest *)request;

- (NSString *)authCodeFromRequest:(NSURLRequest *)request;

@end
