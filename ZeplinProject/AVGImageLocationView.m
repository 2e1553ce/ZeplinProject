//
//  AVGImageLocationView.m
//  ZeplinProject
//
//  Created by aiuar on 25.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGImageLocationView.h"
#import "UIColor+AVGColor.h"
#import "UIFont+AVGFont.h"
#import <Masonry.h>

@implementation AVGImageLocationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = UIFont.nickName;
    
    _locationLabel = [UILabel new];
    _locationLabel.textColor = UIColor.customLightGrayColor;
    _locationLabel.font = UIFont.imageLocation;
    
    _avatarImageView = [UIImageView new];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 16.f;
    
    _locationImageView = [UIImageView new];
    
    [self addSubview:_nickNameLabel];
    [self addSubview:_locationLabel];
    [self addSubview:_avatarImageView];
    [self addSubview:_locationImageView];
    
    UIView *superview = self;
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(1);
        make.bottom.equalTo(superview).with.offset(-1);
        make.left.equalTo(superview);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(16);
        make.right.equalTo(superview).with.offset(-2);
        make.height.equalTo(@16);
    }];
    
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).with.offset(6);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(16);
        make.width.equalTo(@8);
        make.height.equalTo(@10);
    }];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).with.offset(3);
        make.left.equalTo(_locationImageView.mas_right).with.offset(4);
        make.right.equalTo(superview).with.offset(-2);
        make.height.equalTo(@15);
    }];
}

@end
