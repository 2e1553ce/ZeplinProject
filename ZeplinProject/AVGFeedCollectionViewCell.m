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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [UIImageView new];
        _imageView.frame = self.frame;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end
