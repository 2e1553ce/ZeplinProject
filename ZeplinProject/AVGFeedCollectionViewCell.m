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
        //self.layer.borderWidth = 1.f;
        //self.layer.borderColor = UIColor.blackColor.CGColor;
        self.searchedImageView = [AVGSearchImageView new];
        [self addSubview:_searchedImageView];
        
#warning почему если ставлю фрейм - баг
        [_searchedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
        }];
    }
    return self;
}

- (void)prepareForReuse {
    _searchedImageView = nil;
}

@end
