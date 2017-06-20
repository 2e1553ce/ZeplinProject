//
//  AVGDetailedViewController.m
//  ZeplinProject
//
//  Created by aiuar on 20.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedViewController.h"
#import "AVGDetailedImageCell.h"
#import <Masonry.h>

@interface AVGDetailedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AVGDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView *vieww = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    //vieww.backgroundColor = UIColor.redColor;
    //self.navigationItem.
    
    self.tableView = [UITableView new];
    [self.tableView registerClass:[AVGDetailedImageCell class] forCellReuseIdentifier:detailedImageCellIdentifier];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVGDetailedImageCell *cell = [tableView dequeueReusableCellWithIdentifier:detailedImageCellIdentifier forIndexPath:indexPath];
    
    cell.detailedImageView.image = self.image;
    cell.detailedDescriptionLabel.text = @"Описание описание описание описание описание описание";
    
    return  cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AVGDetailedImageCell heightForCell];
}

@end
