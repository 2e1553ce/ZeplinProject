//
//  AVGDetailedLikesCell.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedLikesCell.h"

NSString *const detailedLikesCellIdentifier = @"detailedLikesCellIdentifier";

@implementation AVGDetailedLikesCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

#pragma mark - Constraints

- (void)createSubviews {
    _likesImageView = [UIImageView new];
    _likesImageView.image = [UIImage imageNamed:@"btnLikeSuggestion"];
    
    _commentsImageView = [UIImageView new];
    _commentsImageView.image = [UIImage imageNamed:@"fill984"];
    
    _likesLabel = [UILabel new];
    _likesLabel.font = UIFont.imageDescription;
    _likesLabel.textColor = UIColor.customLightGrayColor;
    
    _commentsLabel = [UILabel new];
    _commentsLabel.font = UIFont.imageDescription;
    _commentsLabel.textColor = UIColor.customLightGrayColor;
    
    [self addSubview:_likesImageView];
    [self addSubview:_commentsImageView];
    [self addSubview:_likesLabel];
    [self addSubview:_commentsLabel];
    
    UIView *superview = self;
    // Masonry
    [_likesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(21.2f);
        make.left.equalTo(superview).with.offset(16.f);
        make.width.equalTo(@15.9f);
        make.height.equalTo(@14.3f);
    }];
    
    [_likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(20.5f);
        make.left.equalTo(self.likesImageView.mas_right).with.offset(7.1f);
        make.height.equalTo(@17.f);
    }];
    
    [_commentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(21.5f);
        make.left.equalTo(_likesLabel.mas_right).with.offset(16.3f);
        make.width.equalTo(@18.f);
        make.height.equalTo(@15.f);
    }];
    
    [_commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(20.5f);
        make.left.equalTo(_commentsImageView.mas_right).with.offset(6.f);
        make.height.equalTo(@17.f);
    }];
}

+ (CGFloat)heightForCell {
    return 55.5f;
}

@end
