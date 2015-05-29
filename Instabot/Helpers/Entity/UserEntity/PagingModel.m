//
//  PagingModel.m
//  InsDemo
//
//  Created by Junwei Lyu on 15/5/28.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "PagingModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation PagingModel

- (NSArray *)getUserFeedWithToken:(NSString *)token
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[NSString stringWithFormat:@"%@", token] forKey:@"access_token"];
    
    [manager POST:USER_FEED parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    return nil;
}

@end
