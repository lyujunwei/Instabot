//
//  FeedCollectionViewCell.h
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *FeedImageView;

- (void)updateCollectionCellWith:(UserDataModule *)userData;

+ (CGFloat)getCollectionCellHeight;

@end
