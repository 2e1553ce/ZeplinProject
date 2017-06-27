//
//  AVGSettingsCell.m
//  ZeplinProject
//
//  Created by aiuar on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGSettingsCell.h"

NSString *const settingsCellIdentifier = @"settingsCellIdentifier";

@implementation AVGSettingsCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

#pragma mark - Creating subviews

- (void)createSubviews {
    _titleLabel = [UILabel new];
    _titleLabel.font = UIFont.settingsTitle;
    [self addSubview:_titleLabel];
    
    UIView *superview = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(10);
        make.left.equalTo(superview).with.offset(16);
        make.right.equalTo(superview).with.offset(-27);
        make.bottom.equalTo(superview).with.offset(-12);
    }];
}

#pragma mark - Height of cell

+ (CGFloat)cellHeight {
    return 44.f;
}

@end
