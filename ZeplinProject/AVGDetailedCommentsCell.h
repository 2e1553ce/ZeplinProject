//
//  AVGDetailedCommentsCell.h
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

extern NSString *const detailedCommentsCellIdentifier;

typedef NS_ENUM(NSInteger, AVGCommentType) {
    AVGCommentTypeComment,
    AVGCommentTypeLike,
    AVGCommentTypeSubscribe
};

@interface AVGDetailedCommentsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

/**
 Метод получающий высоту для ячейки
 
 @return Высота
 */
+ (CGFloat)heightForCell;

@end
