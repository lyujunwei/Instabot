//
//  InstagramUser.h
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramUser : NSObject

@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSURL *profilePictureURL;

- (instancetype)initWithDictionary:(NSDictionary *)userResponse;

@end
