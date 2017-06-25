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
#import "UIColor+AVGColor.h"
#import "UIFont+AVGFont.h"
#import <Masonry.h>

@interface AVGDetailedViewController () <UITableViewDelegate, UITableViewDataSource, AVGImageServiceDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVGImageLocationView *locationView;
@property (nonatomic, strong) AVGDetailedImageService *detailedImageService;
@property (nonatomic, strong) NSMutableArray <AVGImageService*> *imageServices;
@property (nonatomic, strong) NSCache *imageCache; // need service

@property (nonatomic, strong) AVGDetailedImageInformation *imageInfo;
@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, strong) AVGImageService *imageService;


@end

@implementation AVGDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction:)];
    barBtn.tintColor = UIColor.customLightBlueColor;
    self.navigationItem.leftBarButtonItem = barBtn;
    
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
        
        NSUInteger countOfServices = [info.commentators count];
        for (NSUInteger i = 0; i < countOfServices; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [_imageServices addObject:imageService];
        }
        
        self.imageService = [AVGImageService new];
        self.imageService.delegate = self;
        self.imageService.imageState = AVGImageStateNormal;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.imageService loadImageFromUrlString:info.ownerAvatarUrl andCache:self.imageCache forRowAtIndexPath:indexPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.locationView.nickNameLabel.text = info.ownerNickName;
            self.locationView.locationImageView.image = [UIImage imageNamed:@"fill2800"];
            self.locationView.locationLabel.text = info.location;
            
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + [self.comments count];//[self.likes count] + [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        AVGDetailedImageCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedImageCellIdentifier forIndexPath:indexPath];
        cell.detailedImageView.image = self.image;
        cell.detailedDescriptionLabel.text = self.imageInfo.imageDescription ? self.imageInfo.imageDescription : self.imageInfo.title;
        return  cell;
        
    } else if (indexPath.row == 1) {
        AVGDetailedLikesCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedLikesCellIdentifier forIndexPath:indexPath];
        
        NSString *likeTitleString;
        if ([self.likes count] % 10 == 1) {
            likeTitleString = @"лайк";
        } else if ([self.likes count] % 10 > 1 && [self.likes count] % 10 < 5) {
            likeTitleString = @"лайка";
        } else {
            likeTitleString = @"лайков";
        }
        
        NSString *commentTitleString;
        if ([self.comments count] % 10 == 1) {
            commentTitleString = @"комментарий";
        } else if ([self.comments count] % 10 > 1 && [self.comments count] % 10 < 5) {
            commentTitleString = @"комментария";
        } else {
            commentTitleString = @"комментариев";
        }
        
        cell.likesLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[self.likes count], likeTitleString];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[self.comments count], commentTitleString];
        return cell;
        
    } else {
        AVGDetailedCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedCommentsCellIdentifier forIndexPath:indexPath];
        AVGCommentator *commentator = self.comments[indexPath.row - 2];
        cell.nickNameLabel.text = commentator.nickName;
        
        NSString *comment = [NSString stringWithFormat:@"прокомментировал фото:\r%@", commentator.comment];
        NSMutableAttributedString *attributedComment =
        [[NSMutableAttributedString alloc]
         initWithString: comment];
        
        [attributedComment addAttribute:NSForegroundColorAttributeName
                     value:UIColor.customLightBlueColor
                     range:NSMakeRange(22, [comment length] - 22)];
        cell.commentLabel.attributedText = attributedComment;
        //cell.commentLabel.text = [NSString stringWithFormat:@"прокомментировал фото:\r%@", commentator.comment];
        //cell.commentLabel.text = [NSString stringWithFormat:@"%@", commentator.comment];
        
        AVGImageService *imageService = self.imageServices[indexPath.row - 2];
        imageService.delegate = self;
        imageService.imageState = AVGImageStateNormal;
        [imageService loadImageFromUrlString:commentator.avatarURL andCache:self.imageCache forRowAtIndexPath:(NSIndexPath *)indexPath];
        
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
        //return [AVGDetailedCommentsCell heightForCell];
        AVGCommentator *commentator = self.comments[indexPath.row - 2];
        //AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        
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
    }
}


#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.row > 1) {
            AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        }
        //cell.searchedImageView.progressView.hidden = NO;
        //cell.searchedImageView.activityIndicatorView.hidden = NO;
        //cell.searchedImageView.progressView.progress = 0.f;
        //[cell.searchedImageView.activityIndicatorView startAnimating];
    });
    
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.row > 1) {
            AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            //cell.searchedImageView.progressView.progress = progress;
        }
    });
    
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.row == 0) {
            if (image) {
                self.locationView.avatarImageView.image = image;
            }
        } else {
            if (image) {
                //AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
                //[_imageCache setObject:image forKey:imageInfo.url];
                
                AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                cell.avatarImageView.image = image;
                //[cell.searchedImageView.activityIndicatorView stopAnimating];
                //cell.searchedImageView.progressView.hidden = YES;
                [cell setNeedsLayout];
            }
        }
    });
}

#pragma mark - Actions 

- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
