//
//  InstabotConfig.h
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#ifndef Instabot_InstabotConfig_h
#define Instabot_InstabotConfig_h

#define InstagramAuthURL    @"https://api.instagram.com"

#define CLIENT_ID           @"3ca82e5ac4164471a7a5b4a5fc95a477"
#define CLIENT_SECRET       @"160383b030654449bf44ff457e31cfb4"
#define WEBSITE_URL         @"http://weibo.com/z3tt"
#define REDIRECT_URI        @"http://weibo.com/z3tt"

#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)


#define kWidth              [UIScreen mainScreen].bounds.size.width
#define kHeight             [UIScreen mainScreen].bounds.size.height

#pragma API

#define USER_FEED           @"https://api.instagram.com/v1/users/self/feed?"
#define USER_RECENT         @"https://api.instagram.com/v1/users/"

#endif
