//
//  PagingModel.h
//  InsDemo
//
//  Created by Junwei Lyu on 15/5/28.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagingModel : NSObject

- (NSArray *)getUserFeedWithToken:(NSString *)token;

@end
