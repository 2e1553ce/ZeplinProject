//
//  AVGDetailedImageCell.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedImageCell.h"

NSString *const detailedImageCellIdentifier = @"detailedImageCellIdentifier";

@implementation AVGDetailedImageCell

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
    
    _detailedImageView = [UIImageView new]; // Стандартную imageView стягивает при клике на ней
    _detailedImageView.contentMode = UIViewContentModeScaleAspectFill;
    _detailedImageView.clipsToBounds = YES;
    
    _detailedDescriptionLabel = [UILabel new];
    _detailedDescriptionLabel.font = UIFont.imageDescription;
    _detailedDescriptionLabel.textColor = UIColor.customLightGrayColor;
    _detailedDescriptionLabel.numberOfLines = 0;
    
    _activityIndicatorView = [UIActivityIndicatorView new];
    _activityIndicatorView.color = UIColor.grayColor;
    
    [self addSubview:_detailedImageView];
    [self addSubview:_detailedDescriptionLabel];
    [self addSubview:_activityIndicatorView];
    
    // Masonry
    UIView *superview = self;
    
    [_detailedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(1);
        make.left.equalTo(superview).with.offset(1);
        make.right.equalTo(superview).with.offset(-1);
        make.height.equalTo(@248);
    }];
    
    [_detailedDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailedImageView.mas_bottom).with.offset(12);
        make.left.equalTo(superview).with.offset(15);
        make.right.equalTo(superview).with.offset(-15);
        make.bottom.equalTo(superview).with.offset(-12);
    }];
    
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_detailedDescriptionLabel);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    [_activityIndicatorView startAnimating];
}

#pragma mark - Cell Height

+ (CGFloat)heightForCell {
    return 313; // imageView + description + 1(offset at top)
}

@end
