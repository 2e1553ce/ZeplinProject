//
//  AVGSearchImageView.m
//  FlickerImages
//
//  Created by aiuar on 23.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGSearchImageView.h"
#import <Masonry.h>

@implementation AVGSearchImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        // Constraints for indicator & progress
        self.activityIndicatorView = [UIActivityIndicatorView new];
        self.activityIndicatorView.color = UIColor.grayColor;
        [self addSubview:_activityIndicatorView];
        
        self.progressView = [UIProgressView new];
        [self addSubview:self.progressView];
        self.progressView.progress = 0.f;
        
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(@(self.center.y));
            make.centerX.equalTo(@(self.center.x));
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(5);
            make.right.equalTo(self).with.offset(-5);
            make.height.equalTo(@3);
            make.bottom.equalTo(self).with.offset(-5);
            make.centerX.equalTo(@(self.center.x));
        }];
    }
    return self;
}

@end
