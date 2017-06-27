//
//  AVGSettingsCell.h
//  ZeplinProject
//
//  Created by aiuar on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

extern NSString *const settingsCellIdentifier;

@interface AVGSettingsCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;


/**
 Cell for height

 @return Height
 */
+ (CGFloat)cellHeight;

@end
