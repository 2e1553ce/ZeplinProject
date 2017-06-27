//
//  AVGDetailedViewController.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedViewController.h"
#import "AVGDetailedImageCell.h"
#import "AVGDetailedLikesCell.h"
#import "AVGDetailedCommentsCell.h"
#import "AVGDetailedImageService.h"
#import "AVGDetailedImageInformation.h"
#import "AVGImageService.h"
#import "AVGImageLocationView.h"

@interface AVGDetailedViewController () <UITableViewDelegate, UITableViewDataSource, AVGImageServiceDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVGImageLocationView *locationView;
@property (nonatomic, strong) AVGDetailedImageService *detailedImageService;
@property (nonatomic, strong) NSMutableArray<AVGImageService*> *imageServices;
@property (nonatomic, strong) NSCache *imageCache; // need service

@property (nonatomic, strong) AVGDetailedImageInformation *imageInfo;
@property (nonatomic, copy) NSArray *likesAndComments;
@property (nonatomic, copy) NSArray *likes;
@property (nonatomic, copy) NSArray *comments;

@property (nonatomic, strong) AVGImageService *imageService;


@end

@implementation AVGDetailedViewController

#pragma mark - Life cycle of view controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction:)];
    barBtn.tintColor = UIColor.customLightBlueColor;
    self.navigationItem.leftBarButtonItem = barBtn;
    
    UIBarButtonItem *addToFavoritesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavoriteAction:)];
    self.navigationItem.rightBarButtonItem = addToFavoritesButton;
    
    self.locationView = [AVGImageLocationView new];
    self.navigationItem.titleView = self.locationView;
    UIView *titleView = self.navigationItem.titleView;
    CGFloat width = CGRectGetWidth(self.view.frame) - 80.f;
    [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView);
        make.width.equalTo(@(width));
        make.height.equalTo(@34);
    }];
    
    self.imageServices = [NSMutableArray new];
    self.imageCache = [NSCache new];
    _imageCache.countLimit = 50;
    
    self.tableView = [UITableView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[AVGDetailedImageCell class] forCellReuseIdentifier:detailedImageCellIdentifier];
    [self.tableView registerClass:[AVGDetailedLikesCell class] forCellReuseIdentifier:detailedLikesCellIdentifier];
    [self.tableView registerClass:[AVGDetailedCommentsCell class] forCellReuseIdentifier:detailedCommentsCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *superview = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(0);
        make.left.equalTo(superview).with.offset(0);
        make.right.equalTo(superview).with.offset(0);
        make.bottom.equalTo(superview).with.offset(0);
    }];
    
    self.detailedImageService = [[AVGDetailedImageService alloc] initWithImageID:self.imageID];
    [self.detailedImageService getImageInformationWithCompletionHandler:^(AVGDetailedImageInformation *info) {
        self.imageInfo = info;
        self.likes = info.likesInfo;
        self.comments = info.commentators;
        
        NSMutableArray *commentsAndLikes = [NSMutableArray arrayWithArray:self.comments];
        [commentsAndLikes addObjectsFromArray:self.likes];
        
        self.likesAndComments = [commentsAndLikes sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            AVGCommentator *commentator1 = [AVGCommentator new];
            AVGCommentator *commentator2 = [AVGCommentator new];
            AVGLikeInformation *like1 = [AVGLikeInformation new];
            AVGLikeInformation *like2 = [AVGLikeInformation new];
            
            NSDate *dateOne, *dateTwo;
            NSTimeInterval secondsOne, secondsTwo;
            
            
            
            
            if ([obj1 isKindOfClass:[AVGCommentator class]]) {
                commentator1 = (AVGCommentator *)obj1;
                if ([obj2 isKindOfClass:[AVGCommentator class]]) {
                    commentator2 = (AVGCommentator *)obj2;
                    secondsOne = [commentator1.date doubleValue];
                    dateOne = [NSDate dateWithTimeIntervalSince1970:secondsOne];
                    secondsTwo = [commentator2.date doubleValue];
                    dateTwo = [NSDate dateWithTimeIntervalSince1970:secondsTwo];
                } else {
                    like2 = (AVGLikeInformation *)obj2;
                    secondsOne = [commentator1.date doubleValue];
                    dateOne = [NSDate dateWithTimeIntervalSince1970:secondsOne];
                    secondsTwo = [like2.date doubleValue];
                    dateTwo = [NSDate dateWithTimeIntervalSince1970:secondsTwo];
                }
            } else {
                like1 = (AVGLikeInformation *)obj1;
                if ([obj2 isKindOfClass:[AVGCommentator class]]) {
                    commentator2 = (AVGCommentator *)obj2;
                    secondsOne = [like1.date doubleValue];
                    dateOne = [NSDate dateWithTimeIntervalSince1970:secondsOne];
                    secondsTwo = [commentator2.date doubleValue];
                    dateTwo = [NSDate dateWithTimeIntervalSince1970:secondsTwo];
                } else {
                    like2 = (AVGLikeInformation *)obj2;
                    secondsOne = [like1.date doubleValue];
                    dateOne = [NSDate dateWithTimeIntervalSince1970:secondsOne];
                    secondsTwo = [like2.date doubleValue];
                    dateTwo = [NSDate dateWithTimeIntervalSince1970:secondsTwo];
                }
            }
            
            return [dateOne compare:dateTwo];
        }];
        
        NSUInteger countOfServices = [self.likesAndComments count];
        for (NSUInteger i = 0; i < countOfServices; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [_imageServices addObject:imageService];
        }
        
        self.imageService = [AVGImageService new];
        self.imageService.delegate = self;
        self.imageService.imageState = AVGImageStateNormal;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        if (info.ownerAvatarUrl) {
            [self.imageService loadImageFromUrlString:info.ownerAvatarUrl andCache:self.imageCache forRowAtIndexPath:indexPath];
        } else {
            self.locationView.avatarImageView.image = [UIImage imageNamed:@"default_avatar"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.locationView.nickNameLabel.text = info.ownerNickName;
            self.locationView.locationImageView.image = [UIImage imageNamed:@"fill2800"];
            self.locationView.locationLabel.text = info.location;
            
            [self.tableView reloadData];
        });
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + [self.likesAndComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Image & description counters
    if (indexPath.row == 0) {
        AVGDetailedImageCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedImageCellIdentifier forIndexPath:indexPath];
        cell.detailedImageView.image = self.image;
        cell.detailedDescriptionLabel.text = self.imageInfo.imageDescription ? self.imageInfo.imageDescription : self.imageInfo.title;
        return  cell;
        
    }
    // Likes & comments
    else if (indexPath.row == 1) {
        AVGDetailedLikesCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedLikesCellIdentifier forIndexPath:indexPath];
        
        NSString *likeTitleString = [NSString declensionStringFor:AVGDeclensionTypeLike andCount:[self.likes count]];
        NSString *commentTitleString = [NSString declensionStringFor:AVGDeclensionTypeComment andCount:[self.comments count]];
        
        cell.likesLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[self.likes count], likeTitleString];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[self.comments count], commentTitleString];
        return cell;
        
    }
    // Comments
    else {
        AVGDetailedCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedCommentsCellIdentifier forIndexPath:indexPath];
        if ([self.likesAndComments[indexPath.row - 2] isKindOfClass:[AVGCommentator class]]) {
            AVGCommentator *commentator = self.likesAndComments[indexPath.row - 2];
            cell.nickNameLabel.text = commentator.nickName;
            
            NSString *comment = [NSString stringWithFormat:@"прокомментировал фото:\r%@", commentator.comment];
            NSMutableAttributedString *attributedComment =
            [[NSMutableAttributedString alloc]
             initWithString: comment];
            
            [attributedComment addAttribute:NSForegroundColorAttributeName
                                      value:UIColor.customLightBlueColor
                                      range:NSMakeRange(22, [comment length] - 22)];
            cell.commentLabel.attributedText = attributedComment;
            
            AVGImageService *imageService = self.imageServices[indexPath.row - 2];
            imageService.delegate = self;
            imageService.imageState = AVGImageStateNormal;
            if (commentator.avatarURL) {
                [imageService loadImageFromUrlString:commentator.avatarURL andCache:self.imageCache forRowAtIndexPath:(NSIndexPath *)indexPath];
            } else {
                cell.avatarImageView.image = [UIImage imageNamed:@"default_avatar"];
            }
            
        } else {
            AVGLikeInformation *like = self.likesAndComments[indexPath.row - 2];
            cell.nickNameLabel.text = like.nickName;
            
            NSString *comment = [NSString stringWithFormat:@"оценил ваше фото."];
            NSMutableAttributedString *attributedComment =
            [[NSMutableAttributedString alloc]
             initWithString: comment];
            
            [attributedComment addAttribute:NSForegroundColorAttributeName
                                      value:UIColor.customMiddleRedColor
                                      range:NSMakeRange(0, 6)];
            cell.commentLabel.attributedText = attributedComment;
            
            AVGImageService *imageService = self.imageServices[indexPath.row - 2];
            imageService.delegate = self;
            imageService.imageState = AVGImageStateNormal;
            if (like.avatarURL) {
                [imageService loadImageFromUrlString:like.avatarURL andCache:self.imageCache forRowAtIndexPath:(NSIndexPath *)indexPath];
            } else {
                cell.avatarImageView.image = [UIImage imageNamed:@"default_avatar"];
            }
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [AVGDetailedImageCell heightForCell];
    } else if (indexPath.row == 1) {
        return [AVGDetailedLikesCell heightForCell];
    } else {
        if ([self.likesAndComments[indexPath.row - 2] isKindOfClass:[AVGCommentator class]]) {
            AVGCommentator *commentator = self.likesAndComments[indexPath.row - 2];
            
            NSStringDrawingContext *ctx = [NSStringDrawingContext new];
            NSString *commentString = [NSString stringWithFormat:@"прокомментировал фото:\r%@", commentator.comment];
            NSAttributedString *aString = [[NSAttributedString alloc] initWithString:commentString];
            UILabel *calculationLabel = [UILabel new];
            calculationLabel.font = UIFont.comment;
            [calculationLabel setAttributedText:aString];
            CGSize sizeForLabel = CGSizeMake(CGRectGetWidth(self.view.bounds) - 72.f, CGFLOAT_MAX); // 72 for offset between comment and left border
            CGRect textRect = [calculationLabel.text boundingRectWithSize:sizeForLabel options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationLabel.font} context:ctx];
            
            if ([AVGDetailedCommentsCell heightForCell] > textRect.size.height + 44.48) { // 44.48 => min height of commentLabel is 15.52.f(textRect), height of cell is 60.f
                return [AVGDetailedCommentsCell heightForCell];
            } else {
                return 44.48f + textRect.size.height;
            }

        } else {
            NSStringDrawingContext *ctx = [NSStringDrawingContext new];
            NSString *commentString = [NSString stringWithFormat:@"оценил ваше фото."];
            NSAttributedString *aString = [[NSAttributedString alloc] initWithString:commentString];
            UILabel *calculationLabel = [UILabel new];
            calculationLabel.font = UIFont.comment;
            [calculationLabel setAttributedText:aString];
            CGSize sizeForLabel = CGSizeMake(CGRectGetWidth(self.view.bounds) - 72.f, CGFLOAT_MAX); // 72 for offset between comment and left border
            CGRect textRect = [calculationLabel.text boundingRectWithSize:sizeForLabel options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationLabel.font} context:ctx];
            
            if ([AVGDetailedCommentsCell heightForCell] > textRect.size.height + 44.48) { // 44.48 => min height of commentLabel is 15.52.f(textRect), height of cell is 60.f
                return [AVGDetailedCommentsCell heightForCell];
            } else {
                return 44.48f + textRect.size.height;
            }

        }
    }
}

#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    // required but no needed
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    // required but no needed
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.row == 0) {
            if (image) {
                self.locationView.avatarImageView.image = image;
            }
        } else {
            if (image) {
                AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                cell.avatarImageView.image = image;
                [cell setNeedsLayout];
            }
        }
    });
}

#pragma mark - Actions 

- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addToFavoriteAction:(UIBarButtonItem *)sender {
    
}

@end
