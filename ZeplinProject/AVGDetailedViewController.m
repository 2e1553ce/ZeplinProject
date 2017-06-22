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
#import <Masonry.h>

@interface AVGDetailedViewController () <UITableViewDelegate, UITableViewDataSource, AVGImageServiceDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVGDetailedImageService *detailedImageService;
@property (nonatomic, strong) NSMutableArray <AVGImageService*> *imageServices;
@property (nonatomic, strong) NSCache *imageCache; // need service

@property (nonatomic, strong) AVGDetailedImageInformation *imageInfo;
@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *comments;

@end

@implementation AVGDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    //vieww.backgroundColor = UIColor.redColor;
    //self.navigationItem.
    self.imageServices = [NSMutableArray new];
    self.imageCache = [NSCache new];
    _imageCache.countLimit = 50;
    
    self.tableView = [UITableView new];
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
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
        cell.likesLabel.text = [NSString stringWithFormat:@"%lu лайка", (unsigned long)[self.likes count]];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%lu комментария", (unsigned long)[self.comments count]];
        return cell;
        
    } else {
        AVGDetailedCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedCommentsCellIdentifier forIndexPath:indexPath];
        AVGCommentator *commentator = self.comments[indexPath.row - 2];
        cell.nickNameLabel.text = commentator.nickName;
        cell.commentLabel.text = commentator.comment;
        
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
        return [AVGDetailedCommentsCell heightForCell];
    }
}


#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        //cell.searchedImageView.progressView.hidden = NO;
        //cell.searchedImageView.activityIndicatorView.hidden = NO;
        //cell.searchedImageView.progressView.progress = 0.f;
        //[cell.searchedImageView.activityIndicatorView startAnimating];
    });
    
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        //cell.searchedImageView.progressView.progress = progress;
    });
    
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"");
        if (image) {
            //AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
            //[_imageCache setObject:image forKey:imageInfo.url];
            
            AVGDetailedCommentsCell *cell = (AVGDetailedCommentsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.avatarImageView.image = image;
            //[cell.searchedImageView.activityIndicatorView stopAnimating];
            //cell.searchedImageView.progressView.hidden = YES;
            [cell setNeedsLayout];
        }
    });
}

@end
