//
//  AVGDetailedImageCell.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedImageCell.h"
#import "UIFont+AVGFont.h"
#import "UIColor+AVGColor.h"
#import "Masonry.h"

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

#pragma mark - Constraints

- (void)createSubviews {
    
    self.detailedImageView = [UIImageView new]; // Стандартную imageView стягивает при клике на ней
    
    self.detailedDescriptionLabel = [UILabel new];
    self.detailedDescriptionLabel.font = [UIFont imageDescription];
    self.detailedDescriptionLabel.textColor = [UIColor imageDescription];
    self.detailedDescriptionLabel.numberOfLines = 0;
    
    [self addSubview:self.detailedImageView];
    [self addSubview:self.detailedDescriptionLabel];
    
    // Masonry
    UIView *superview = self;
    
    [self.detailedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(1);
        make.left.equalTo(superview).with.offset(1); // wtf
        make.right.equalTo(superview).with.offset(-1);
        make.height.equalTo(@248);
    }];
    
    [self.detailedDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailedDescriptionLabel).with.offset(12);
        make.left.equalTo(superview).with.offset(15);
        make.right.equalTo(superview).with.offset(-15);
        make.height.lessThanOrEqualTo(@40);
        make.bottom.equalTo(superview).with.offset(-12); // dynamic
    }];
}

#pragma mark - Cell Height

+ (CGFloat)heightForCell {
    return 313; // imageView + description + 1(offset at top)
}

@end
