//
//  AVGFavoriteViewController.m
//  ZeplinProject
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFavoriteViewController.h"
#import "AVGStorageFacade.h"
#import "AVGFavoriteCell.h"
#import "AVGDetailedImageInformation.h"

@interface AVGFavoriteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *favoriteTableView;
@property (nonatomic, strong) AVGStorageFacade *storageFacade;
@property (nonatomic, strong) NSArray *imagesInfo;

@end

@implementation AVGFavoriteViewController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Избранное" image:[UIImage imageNamed:@"icLikes"] tag:1];
        tabBarItem.titlePositionAdjustment = UIOffsetMake(-20, 0);
        self.tabBarItem = tabBarItem;
        
        _storageFacade = [AVGStorageFacade new];
    }
    return self;
}

#pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewController];
    [self configureTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imagesInfo = [self.storageFacade getImagesWithInformation];
    [self.favoriteTableView reloadData];
}

#pragma mark - Interface configuration

- (void)configureViewController {
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Избранное";
}

- (void)configureTableView {
    self.favoriteTableView = [UITableView new];
    [self.favoriteTableView registerClass:[AVGFavoriteCell class] forCellReuseIdentifier:favoriteCellIdentifier];
    self.favoriteTableView.dataSource = self;
    self.favoriteTableView.delegate = self;
    [self.view addSubview:self.favoriteTableView];
    
    UIView *superview = self.view;
    [self.favoriteTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview);
        make.left.equalTo(superview);
        make.right.equalTo(superview);
        make.bottom.equalTo(superview);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imagesInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVGFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:favoriteCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *imageDict = self.imagesInfo[indexPath.row];
    UIImage *image = imageDict[@"image"];
    AVGDetailedImageInformation *detailedInfo = imageDict[@"imageInformation"];
    
    cell.favoriteImageView.image = image;
    cell.titleLabel.text = detailedInfo.title;
    cell.locationLabel.text = detailedInfo.location;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AVGFavoriteCell heightForCell];
}

@end
