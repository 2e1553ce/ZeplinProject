//
//  AVGFeedCollectionViewCell.m
//  ZeplinProject
//
//  Created by aiuar on 10.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFeedCollectionViewCell.h"
#import <Masonry.h>

NSString *const flickrCellIdentifier = @"flickrCellIdentifier";

@implementation AVGFeedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.searchedImageView = [AVGSearchImageView new];
        [self addSubview:self.searchedImageView];

        [self.searchedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
        }];
        
        self.label = [UILabel new];
        [self.searchedImageView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@40);
        }];
    }
    return self;
}

- (void)prepareForReuse {
    self.searchedImageView.image = nil;
}

@end
