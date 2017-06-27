//
//  AVGDetailedCommentsCell.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedCommentsCell.h"
#import "UIFont+AVGFont.h"
#import "UIColor+AVGColor.h"
#import <Masonry.h>

NSString *const detailedCommentsCellIdentifier = @"detailedCommentsCellIdentifier";

@implementation AVGDetailedCommentsCell

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
    _avatarImageView = [UIImageView new];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 19.f;
    
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = UIFont.nickName;
    
    _commentLabel = [UILabel new];
    _commentLabel.numberOfLines = 0;
    _commentLabel.font = UIFont.comment;
    _commentLabel.textColor = UIColor.customLightGrayColor;
    
    [self addSubview:_avatarImageView];
    [self addSubview:_nickNameLabel];
    [self addSubview:_commentLabel];
    
    UIView *superview = self;
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(11);
        make.left.equalTo(superview).with.offset(16);
        make.width.equalTo(@38);
        make.height.equalTo(@38);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(14);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(8);
        make.right.equalTo(superview).with.offset(-10);
        make.height.equalTo(@16);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(8);
        make.right.equalTo(superview).with.offset(-10);
        make.bottom.equalTo(superview).with.offset(-14);
    }];
}

+ (CGFloat)heightForCell {
    return 60.f;
}

@end
