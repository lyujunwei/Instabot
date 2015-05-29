//
//  GlobalVariables.m
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

+ (GlobalVariables *)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (void)saveUserInfo:(InstagramLoginResponse *)user
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [defaults setObject:userData forKey:@"InstagramLoginResponse"];
    [defaults synchronize];
}

+ (BOOL)loadUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [defaults objectForKey:@"InstagramLoginResponse"];
    InstagramLoginResponse *instaUser = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (instaUser.accessToken.length > 0) {
        return YES;
    }
    return NO;
}

+ (InstagramLoginResponse *)getInstagramUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [defaults objectForKey:@"InstagramLoginResponse"];
    InstagramLoginResponse *instaUser = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return instaUser;
}

@end
