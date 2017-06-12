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
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = UIColor.blackColor.CGColor;
        self.imageView = [UIImageView new];
        [self addSubview:_imageView];
        
#warning почему если ставлю фрейм - баг
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(2);
            make.bottom.equalTo(self).with.offset(2);
            make.left.equalTo(self).with.offset(2);
            make.right.equalTo(self).with.offset(2);
        }];
    }
    return self;
}

@end
