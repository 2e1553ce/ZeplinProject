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
    _searchedImageView = [UIImageView new];
    
    _activityIndicatorView = [UIActivityIndicatorView new];
    _activityIndicatorView.color = UIColor.grayColor;
    
    _progressView = [UIProgressView new];
    _progressView.progress = 0.f;
    
    [self addSubview:_searchedImageView];
    [self.searchedImageView addSubview:_activityIndicatorView];
    [self.searchedImageView addSubview:_progressView];
    
    [_searchedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];

    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.center.equalTo(_searchedImageView);
    }];

    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchedImageView).with.offset(5);
        make.right.equalTo(_searchedImageView).with.offset(-5);
        make.height.equalTo(@2);
        make.bottom.equalTo(_searchedImageView).with.offset(-5);
    }];
 
}

@end
