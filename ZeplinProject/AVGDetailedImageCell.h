//
//  AVGDetailedImageCell.h
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const detailedImageCellIdentifier;

@interface AVGDetailedImageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *detailedImageView;
@property (nonatomic, strong) UILabel *detailedDescriptionLabel;

+ (CGFloat)heightForCell;

@end
