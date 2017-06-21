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
#import <Masonry.h>

@interface AVGDetailedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVGDetailedImageService *detailedImageService;

@end

@implementation AVGDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    //vieww.backgroundColor = UIColor.redColor;
    //self.navigationItem.
    
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
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        AVGDetailedImageCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedImageCellIdentifier forIndexPath:indexPath];
        cell.detailedImageView.image = self.image;
        cell.detailedDescriptionLabel.text = @"Is there any way to have a label wordwrap text as needed? I have the line breaks set to word wrap and the label is tall enough for two lines, but it appears that it will only wrap on line breaks. Do I have to add line breaks to make it wrap properly? I just want it to wrap if it can't fit it in horizontally.";
        return  cell;
        
    } else if (indexPath.row == 1) {
        AVGDetailedLikesCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedLikesCellIdentifier forIndexPath:indexPath];
        cell.likesLabel.text = @"10 lukasov";
        cell.commentsLabel.text = @"10 commentsov";
        return cell;
        
    } else {
        AVGDetailedCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedCommentsCellIdentifier forIndexPath:indexPath];
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

@end
