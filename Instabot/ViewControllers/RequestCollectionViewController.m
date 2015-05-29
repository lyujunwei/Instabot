//
//  RequestCollectionViewController.m
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "RequestCollectionViewController.h"
#import "FeedCollectionViewCell.h"

@interface RequestCollectionViewController ()

@end

@implementation RequestCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViewRefreshing];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRefreshing:(InstagramLoginResponse *)response
{

}

- (void)loadingMore:(InstagramLoginResponse *)response
{

}

- (void)setTableViewRefreshing
{
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        if (_loginResponse.accessToken) {
            [self.collectionView.header beginRefreshing];
            [self startRefreshing:_loginResponse];
        }
    }];
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        if (_loginResponse.accessToken) {
            [self.collectionView.footer beginRefreshing];
            [self loadingMore:_loginResponse];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"Cell";
    FeedCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (_items && _items.count > 0) {
        [cell updateCollectionCellWith:_items[indexPath.row]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(172, 172);
}

@end
