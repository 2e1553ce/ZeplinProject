//
//  AVGFeedCollectionViewCell.h
//  ZeplinProject
//
//  Created by aiuar on 10.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

extern NSString *const flickrCellIdentifier;

@interface AVGFeedCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *searchedImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIProgressView *progressView;

@end
