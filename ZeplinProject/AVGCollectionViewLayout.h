//
//  AVGCollectionViewLayout.h
//  ZeplinProject
//
//  Created by aiuar on 19.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGCollectionViewLayout;

@protocol AVGCollectionViewLayoutDelegate <UICollectionViewDelegate>

/**
 Method for taking width of item in collection view

 @param layout Custom layout
 @param indexPath Indexpath for item
 @return Width
 */
- (CGFloat)collectionLayout:(AVGCollectionViewLayout*)layout preferredWidthForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 Method for taking insets for item in collection view

 @param layout Custom layout
 @param indexPath Indexpath for item
 @return Insets
 */
- (UIEdgeInsets)collectionLayout:(AVGCollectionViewLayout*)layout edgeInsetsForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AVGCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<AVGCollectionViewLayoutDelegate> delegate;

@end
