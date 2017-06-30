//
//  AVGCollectionViewLayout.m
//  ZeplinProject
//
//  Created by aiuar on 19.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGCollectionViewLayout.h"

@interface AVGCollectionViewLayout ()

// Saved prelayout frames with index path as key
@property (nonatomic, strong) NSMutableDictionary *framesByIndexPath;
// Stores cached index paths with frames as key
@property (nonatomic, strong) NSMutableDictionary *indexPathsByFrame;
// Cached attributes, were returned with layoutAttributesForElementsInRect: method last time
@property (nonatomic, strong) NSMutableArray* previousLayoutAttributes;
// Rectangle for cached layout attributes for elements in rect returned last time
@property (nonatomic, assign) CGRect previousLayoutRect;

@property (nonatomic, assign) CGRect lastFrame;
@property (nonatomic, strong) NSMutableArray *matrix;
@property (nonatomic, assign) NSInteger countOfItems;
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) CGFloat lowerestCellWidth;

@end

@implementation AVGCollectionViewLayout

#pragma mark - Initialization

- (id)init {
    if (self = [super init]) {
        _framesByIndexPath = [NSMutableDictionary new];
        _indexPathsByFrame = [NSMutableDictionary new];
        _previousLayoutAttributes = [[NSMutableArray alloc] init];
        _lastFrame = CGRectZero;
    }
    return self;
}

#pragma mark Overridden methods of UICollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.framesByIndexPath removeAllObjects];
    [self.indexPathsByFrame removeAllObjects];
    [self.previousLayoutAttributes removeAllObjects];

    self.lastFrame = CGRectZero;
    _lowerestCellWidth = [_delegate lowerestCellWidth];
    
    [self createMatrix];
    // calculate and save frames for all indexPaths. Unfortunately, we must do it for all cells to know content size of the collection
    for (int i = 0; i < [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        [self frameForIndexPath:path];
    }
}

// cleanup every cached data if current layout becomes invalid
- (void)invalidateLayout {
    [self.framesByIndexPath removeAllObjects];
    [self.indexPathsByFrame removeAllObjects];
    [self.previousLayoutAttributes removeAllObjects];
    self.previousLayoutRect = CGRectZero;
    [super invalidateLayout];
}

#pragma mark - Matrix

- (void)createMatrix {
    self.countOfItems = [self.delegate countOfItems];
    self.rows = self.countOfItems % 3 == 0 ? self.countOfItems / 3 : (self.countOfItems / 3) + 1;;
    self.columns = 3;
    
    self.matrix = [NSMutableArray new];
    for (NSUInteger i = 0; i < self.countOfItems; i++) {
        [self.matrix addObject:[NSMutableArray new]];
    }
    
    for (NSUInteger i = 0; i < self.rows; i++) {
        for (NSUInteger j = 0; j < self.columns; j++) {
            self.matrix[i][j] = @(YES);;
        }
    }
}

#pragma mark Methods for UICollectionLayout customization

- (CGSize)collectionViewContentSize {
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    CGFloat maxY = CGRectGetMaxY(self.lastFrame);
    return CGSizeMake(width, maxY);
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    // Return saved attributes if there are cached attributes for this rect
    if (CGRectEqualToRect(rect, self.previousLayoutRect)) {
        return self.previousLayoutAttributes;
    }
    [self.previousLayoutAttributes removeAllObjects];
    self.previousLayoutRect = rect;
    
    // Let's take all prelayouted frames and add to the result array if they intersect given rect
    NSArray *allFrames = self.framesByIndexPath.allValues;
    int count = 0;
    for (NSValue *frameValue in allFrames) {
        ++count;
        CGRect rectt = [frameValue CGRectValue];
        if (CGRectIntersectsRect(rectt, rect)) {
            [self.previousLayoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:[self.indexPathsByFrame objectForKey:[NSValue valueWithCGRect:rectt]]]];
        }
    }
    return self.previousLayoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if ([self.delegate respondsToSelector:@selector(collectionLayout:edgeInsetsForItemAtIndexPath:)]) {
        insets = [self.delegate collectionLayout:self edgeInsetsForItemAtIndexPath:indexPath];
    }
    
    CGRect frame = [self frameForIndexPath:indexPath];
    // Get saved frame and edge insets for given path and create attributes object with them
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = UIEdgeInsetsInsetRect(frame, insets);
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}

#pragma mark Supplementary methods

- (CGRect)frameForIndexPath:(NSIndexPath*)path {
    NSValue *v = [self.framesByIndexPath objectForKey:path];
    if (v) {
        return [v CGRectValue];
    }
    
    CGFloat w = [self.delegate collectionLayout:self preferredWidthForItemAtIndexPath:path];
    CGFloat h = w;
    
    for (NSUInteger i = 0; i < self.rows; i++) {
        for (NSUInteger j = 0; j < self.columns; j++) {
            if ([self.matrix[i][j] boolValue]) {
                if (path.row % 12 == 0 || path.row % 12 == 7) {
                    self.matrix[i][j + 1] = @(NO);
                    self.matrix[i + 1][j] = @(NO);
                    self.matrix[i + 1][j + 1] = @(NO);
                }
                self.matrix[i][j] = @(NO);
                self.lastFrame = CGRectMake(self.lowerestCellWidth * j, self.lowerestCellWidth * i, w, h);
                [self saveFrame:self.lastFrame andPath:path];
                return self.lastFrame;
            }
        }
    }
    return CGRectZero;
}

#pragma mark - Helper

- (void)saveFrame:(CGRect)frame andPath:(NSIndexPath *)path {
    NSValue *value = [NSValue valueWithCGRect:frame];
    [self.framesByIndexPath setObject:value forKey:path];
    [self.indexPathsByFrame setObject:path forKey:value];
}

@end
