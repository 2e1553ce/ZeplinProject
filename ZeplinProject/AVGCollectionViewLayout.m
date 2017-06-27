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

@property (nonatomic, assign) BOOL isLeftBig;
@property (nonatomic, assign) BOOL isRightBig;

@property (nonatomic, assign) NSInteger leftCounter;
@property (nonatomic, assign) NSInteger rightCounter;

@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation AVGCollectionViewLayout

#pragma mark - Initialization

- (id)init {
    if (self = [super init]) {
        _framesByIndexPath = [NSMutableDictionary new];
        _indexPathsByFrame = [NSMutableDictionary new];
        _previousLayoutAttributes = [[NSMutableArray alloc] init];
        
        _leftCounter = 0;
        _rightCounter = 0;
        _isLeftBig = YES;
        _isRightBig = NO;
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
    
    self.leftCounter = 0;
    self.rightCounter = 0;
    self.isLeftBig = YES;
    self.isRightBig = NO;
    self.lastFrame = CGRectZero;
    
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

// Main method, calculating frames for every 12 frames
- (CGRect)frameForIndexPath:(NSIndexPath*)path {
    NSValue *v = [self.framesByIndexPath objectForKey:path];
    if (v) {
        return [v CGRectValue];
    }
    
    CGFloat w = [self.delegate collectionLayout:self preferredWidthForItemAtIndexPath:path];
    CGFloat h = w;
    
    if (self.isLeftBig && self.leftCounter == 0) {
        self.isLeftBig = NO;
        self.leftCounter++;
        CGFloat x = 0;
        
        CGFloat y;
        if (path == 0) {
            y = 0;
        } else {
            y = CGRectGetMaxY(self.lastFrame);
        }
        
        self.lastFrame = CGRectMake(x, y, w, h);
        [self saveFrame:self.lastFrame andPath:path];
        
        return self.lastFrame;
    } else if (!self.isRightBig) {
        switch (self.leftCounter) {
            case 1: {
                CGFloat x = CGRectGetMaxX(self.lastFrame);
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.leftCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 2: {
                CGFloat x = CGRectGetMinX(self.lastFrame);
                CGFloat y = CGRectGetMaxY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.leftCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 3: {
                CGFloat x = 0;
                CGFloat y = CGRectGetMaxY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.leftCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 4: {
                CGFloat x = CGRectGetMaxX(self.lastFrame);
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.leftCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 5: {
                CGFloat x = CGRectGetMaxX(self.lastFrame);
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                [self saveFrame:self.lastFrame andPath:path];
                
                self.leftCounter = 0;
                self.isRightBig = YES;
                
                return self.lastFrame;
            }
        }
    }
    
    if (self.isRightBig && self.rightCounter == 0) {
        self.rightCounter++;
        
        CGFloat x = CGRectGetMaxX(self.collectionView.bounds) - [self.delegate collectionLayout:self preferredWidthForItemAtIndexPath:path];
        CGFloat y = CGRectGetMaxY(self.lastFrame);
        self.lastFrame = CGRectMake(x, y, w, h);
        [self saveFrame:self.lastFrame andPath:path];
        
        return self.lastFrame;
        
    } else {
        switch (self.rightCounter) {
            case 1: {
                CGFloat x = 0;
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.rightCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 2: {
                CGFloat x = 0;
                CGFloat y = CGRectGetMaxY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.rightCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 3: {
                CGFloat x = 0;
                CGFloat y = CGRectGetMaxY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.rightCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 4: {
                CGFloat x = CGRectGetMaxX(self.lastFrame);
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                self.rightCounter++;
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
            case 5: {
                self.isRightBig = NO;
                self.rightCounter = 0;
                self.isLeftBig = YES;
                
                CGFloat x = CGRectGetMaxX(self.lastFrame);
                CGFloat y = CGRectGetMinY(self.lastFrame);
                self.lastFrame = CGRectMake(x, y, w, h);
                [self saveFrame:self.lastFrame andPath:path];
                
                return self.lastFrame;
            }
        }
    }
    return CGRectZero;
}

#pragma mark - Helper

- (void)saveFrame:(CGRect)frame andPath:(NSIndexPath *)path {
    NSValue *value = [NSValue valueWithCGRect:self.lastFrame];
    [self.framesByIndexPath setObject:value forKey:path];
    [self.indexPathsByFrame setObject:path forKey:value];
}

@end

