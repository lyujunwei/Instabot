//
//  InstagramLoginResponse.m
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "InstagramLoginResponse.h"

NSString *const InstagramAccessTokenKey = @"access_token";
NSString *const InstagramUserKey = @"user";

@interface InstagramLoginResponse ()

@property (copy, nonatomic, readwrite) NSString *accessToken;
@property (strong, nonatomic, readwrite) InstagramUser *user;

@end

@implementation InstagramLoginResponse

#pragma mark - Init Methods

- (instancetype)initWithInstagramOAuthResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        if (response) {
            self.accessToken = response[InstagramAccessTokenKey];
            
            InstagramUser *user = [[InstagramUser alloc] initWithDictionary:response[InstagramUserKey]];
            self.user = user;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.user forKey:@"user"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
    }
    return self;
}

@end
