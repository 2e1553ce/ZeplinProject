//
//  AVGDetailedLikesCell.h
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const detailedLikesCellIdentifier;

@interface AVGDetailedLikesCell : UITableViewCell

@property (nonatomic, strong) UIImageView *likesImageView;
@property (nonatomic, strong) UIImageView *commentsImageView;
@property (nonatomic, strong) UILabel *likesLabel;
@property (nonatomic, strong) UILabel *commentsLabel;

+ (CGFloat)heightForCell;

@end
