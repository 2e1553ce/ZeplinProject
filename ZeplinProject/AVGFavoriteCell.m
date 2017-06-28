//
//  AVGFavoriteCell.m
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

NSString *const favoriteCellIdentifier = @"favoriteCellIdentifier";

#import "AVGFavoriteCell.h"

@implementation AVGFavoriteCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

#pragma mark - Creating subviews

- (void)createSubviews {
    _favoriteImageView = [UIImageView new];
    
    _locationLabel = [UILabel new];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.font = UIFont.imageDescription;
    
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = UIFont.imageDescription;
    
    [self addSubview:_favoriteImageView];
    [self addSubview:_locationLabel];
    [self addSubview:_titleLabel];
    
    UIView *superview = self;
    [_favoriteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(40);
        make.left.equalTo(superview);
        make.right.equalTo(superview);
        make.bottom.equalTo(superview);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview);
        make.left.equalTo(superview);
        make.right.equalTo(superview);
        make.bottom.equalTo(_favoriteImageView.mas_top).with.offset(-20);
    }];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(superview);
        make.right.equalTo(superview);
        make.bottom.equalTo(_favoriteImageView.mas_top);
    }];
}

#pragma mark - Height for cell

+ (CGFloat)heightForCell {
    return 300.f;
}

@end
