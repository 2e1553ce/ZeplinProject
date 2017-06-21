//
//  AVGDetailedLikesCell.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedLikesCell.h"
#import "UIColor+AVGColor.h"
#import "UIFont+AVGFont.h"
#import <Masonry.h>

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
    self.likesImageView = [UIImageView new];
    self.likesImageView.image = [UIImage imageNamed:@"btnLikeSuggestion"];
    
    self.commentsImageView = [UIImageView new];
    self.commentsImageView.image = [UIImage imageNamed:@"fill984"];
    
    self.likesLabel = [UILabel new];
    self.likesLabel.font = UIFont.imageDescription;
    self.likesLabel.textColor = UIColor.imageDescription;
    
    self.commentsLabel = [UILabel new];
    self.commentsLabel.font = UIFont.imageDescription;
    self.commentsLabel.textColor = UIColor.imageDescription;
    
    [self addSubview:self.likesImageView];
    [self addSubview:self.commentsImageView];
    [self addSubview:self.likesLabel];
    [self addSubview:self.commentsLabel];
    
    UIView *superview = self;
    // Masonry
    [self.likesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(21.2f);
        make.left.equalTo(superview).with.offset(16.f);
        make.width.equalTo(@15.9f);
        make.height.equalTo(@14.3f);
    }];
    
    [self.likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(20.5f);
        make.left.equalTo(self.likesImageView.mas_right).with.offset(7.1f);
        make.height.equalTo(@17.f);
    }];
    
    [self.commentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(21.5f);
        make.left.equalTo(self.likesLabel.mas_right).with.offset(16.3f);
        make.width.equalTo(@18.f);
        make.height.equalTo(@15.f);
    }];
    
    [self.commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(20.5f);
        make.left.equalTo(self.commentsImageView.mas_right).with.offset(6.f);
        make.height.equalTo(@17.f);
    }];
}

+ (CGFloat)heightForCell {
    return 55.5f;
}

@end
