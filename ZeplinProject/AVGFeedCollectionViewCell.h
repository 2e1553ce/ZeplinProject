//
//  AVGFeedCollectionViewCell.h
//  ZeplinProject
//
//  Created by aiuar on 10.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVGSearchImageView.h"

extern NSString *const flickrCellIdentifier;

@interface AVGFeedCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) AVGSearchImageView *searchedImageView;
@property (nonatomic, strong) UILabel *label;

@end
