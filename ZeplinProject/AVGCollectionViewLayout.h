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
 Метод запрашивающий ширину ячейки
 @param layout Кастомный лэяут
 @param indexPath Индекс ячейки
 @return Ширина
 */
- (CGFloat)collectionLayout:(AVGCollectionViewLayout*)layout preferredWidthForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 Метод запрашивающий отступы для ячейки

 @param layout Кастомный лэяут
 @param indexPath Индекс ячейки
 @return Insets
 */
- (UIEdgeInsets)collectionLayout:(AVGCollectionViewLayout*)layout edgeInsetsForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 Метод запрашивающий количество ячеек

 @return Количество ячеек
 */
- (NSInteger)countOfItems;

/**
 Метод запрашивающий ширину самой маленькой ячейки

 @return Ширина
 */
- (CGFloat)lowerestCellWidth;

@end

@interface AVGCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<AVGCollectionViewLayoutDelegate> delegate;

@end
