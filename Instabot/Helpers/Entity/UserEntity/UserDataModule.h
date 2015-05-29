//
//  UserDataModule.h
//  InsDemo
//
//  Created by Junwei Lyu on 15/5/28.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserImages : NSObject

@property (nonatomic, strong) NSString *url;

- (id)initWithDict:(NSDictionary *)dict;

@end

@interface UserDataModule : NSObject

@property (strong, nonatomic) UserImages *images;

- (id) initWithDict:(NSDictionary *)dict;

@end

@interface Pagination : NSObject

@property (strong, nonatomic) NSString *next_url;
@property (strong, nonatomic) NSString *next_max_id;

- (id) initWithDict:(NSDictionary *)dict;

@end
