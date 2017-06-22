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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

#pragma mark - Constraints

- (void)createSubviews {
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 19.f;
    
    self.nickNameLabel = [UILabel new];
    self.nickNameLabel.font = UIFont.commentatorNickName;
    
    self.commentLabel = [UILabel new];
    self.commentLabel.font = UIFont.commentatorComment;
    self.commentLabel.textColor = UIColor.commentatorComment;
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.commentLabel];
    
    UIView *superview = self;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(11);
        make.left.equalTo(superview).with.offset(16);
        make.width.equalTo(@38);
        make.height.equalTo(@38);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(14);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(8);
        //make.right.equalTo(superview).with.offset(-10);
        make.height.equalTo(@16);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(8);
        //make.right.equalTo(superview).with.offset(-10);
        make.height.equalTo(@16);
    }];
}

+ (CGFloat)heightForCell {
    return 60.f;
}

@end
