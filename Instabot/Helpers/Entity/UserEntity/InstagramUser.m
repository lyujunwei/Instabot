//
//  InstagramUser.m
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "InstagramUser.h"

NSString *const InstagramIDKey = @"id";
NSString *const InstagramUsernameKey = @"username";
NSString *const InstagramFullNameKey = @"full_name";
NSString *const InstagramProfilePictureKey = @"profile_picture";

@implementation InstagramUser

#pragma mark - Init Methods

- (instancetype)initWithDictionary:(NSDictionary *)userResponse
{
    self = [super init];
    if (self) {
        if (userResponse) {
            self.userID = userResponse[InstagramIDKey];
            self.username = userResponse[InstagramUsernameKey];
            self.fullName = userResponse[InstagramFullNameKey];
            self.profilePictureURL = [NSURL URLWithString:userResponse[InstagramProfilePictureKey]];
        }
    }
    return self;
}

- (instancetype)init
{
    return [self initWithDictionary:nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.fullName forKey:@"fullName"];
    [aCoder encodeObject:self.profilePictureURL forKey:@"profilePictureURL"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.fullName = [aDecoder decodeObjectForKey:@"fullName"];
        self.profilePictureURL = [aDecoder decodeObjectForKey:@"profilePictureURL"];
    }
    return self;
}

@end
