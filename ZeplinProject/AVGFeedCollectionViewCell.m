//
//  AVGFeedCollectionViewCell.m
//  ZeplinProject
//
//  Created by aiuar on 10.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFeedCollectionViewCell.h"

NSString *const flickrCellIdentifier = @"flickrCellIdentifier";

@implementation AVGFeedCollectionViewCell

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

#pragma mark - Reusing

- (void)prepareForReuse {
    self.searchedImageView.image = nil;
}

#pragma mark - Creating subviews

- (void)createSubviews {
    _searchedImageView = [AVGSearchImageView new];
    [self addSubview:_searchedImageView];
    
    [_searchedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
    }];
    
    _label = [UILabel new];
    [_searchedImageView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
}

@end
