//
//  AVGFavoriteCell.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

extern NSString *const favoriteCellIdentifier;

@interface AVGFavoriteCell : UITableViewCell

@property (nonatomic, strong) UIImageView *favoriteImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *locationLabel;

/**
 Высота ячейки

 @return Высота
 */
+ (CGFloat)heightForCell;

@end
