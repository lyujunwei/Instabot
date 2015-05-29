//
//  UserDataModule.m
//  InsDemo
//
//  Created by Junwei Lyu on 15/5/28.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "UserDataModule.h"

@implementation UserImages

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_url forKey:@"url"];
}

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if ([dict objectForKey:@"url"] && [dict objectForKey:@"url"] != [NSNull null]) {
            _url = [dict objectForKey:@"url"];
        }
    }
    return self;
}

@end

@implementation UserDataModule

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _images = [aDecoder decodeObjectForKey:@"images"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_images forKey:@"images"];
}

- (id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if ([dict objectForKey:@"images"] && [dict objectForKey:@"images"] != [NSNull null]) {
            _images = [[UserImages alloc]initWithDict:[[dict objectForKey:@"images"]objectForKey:@"standard_resolution"]];
        }
    }
    return self;
}

@end

@implementation Pagination

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _next_url = [aDecoder decodeObjectForKey:@"next_url"];
        _next_max_id = [aDecoder decodeObjectForKey:@"next_max_id"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_next_url forKey:@"next_url"];
    [aCoder encodeObject:_next_max_id forKey:@"next_max_id"];
}

- (id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if ([dict objectForKey:@"next_url"] && [dict objectForKey:@"next_url"] != [NSNull null]) {
            _next_url = [dict objectForKey:@"next_url"];
        }
        if ([dict objectForKey:@"next_url"] && [dict objectForKey:@"next_url"] != [NSNull null]) {
            _next_max_id = [dict objectForKey:@"next_max_id"];
        }
    }
    return self;
}

@end
