//
//  FeedCollectionViewCell.m
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "FeedCollectionViewCell.h"

@implementation FeedCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCollectionCellWith:(UserDataModule *)userData
{
    [_FeedImageView sd_setImageWithURL:[NSURL URLWithString:userData.images.url]];
}

+ (CGFloat)getCollectionCellHeight
{
    return 172;
}

@end
