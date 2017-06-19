//
//  AVGCollectionViewLayout.h
//  ZeplinProject
//
//  Created by aiuar on 19.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVGCollectionViewLayout;

@protocol AVGCollectionViewLayoutDelegate <UICollectionViewDelegate>

- (CGFloat)collectionLayout:(AVGCollectionViewLayout*)layout preferredWidthForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)contentSize;

@optional

- (UIEdgeInsets)collectionLayout:(AVGCollectionViewLayout*)layout edgeInsetsForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AVGCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<AVGCollectionViewLayoutDelegate> delegate;

@end
