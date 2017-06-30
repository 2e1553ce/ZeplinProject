//
//  AVGFeedViewController.m
//  ZeplinProject
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFeedViewController.h"
#import "AVGFeedCollectionViewCell.h"
#import "AVGCollectionViewLayout.h"
#import "AVGDetailedViewController.h"
#import "AVGSettingsViewController.h"
#import "AVGFeedDataProvider.h"

@interface AVGFeedViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *feedCollectionView;
@property (nonatomic, strong) AVGFeedDataProvider *feedDataProvider;

@end

@implementation AVGFeedViewController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        UITabBar.appearance.tintColor = UIColor.customAzureColor;
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Лента" image:[UIImage imageNamed:@"icFeed"] tag:0];
        [tabBarItem setTitlePositionAdjustment:UIOffsetMake(18, 0)];
        self.tabBarItem = tabBarItem;
        self.feedDataProvider = [AVGFeedDataProvider new];
    }
    return self;
}

#pragma mark - Life cycle of viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.customLightHoarColor;
    
    // Options button at top-right corner
    [self configurateOptionsButton];
    // SearchBar
    [self configurateSearchBar];
    // Collection view
    [self configurateColectionView];
    self.feedDataProvider.navigationController = self.navigationController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Collection view configuration

- (void)configurateColectionView {
    // CollectionView
    AVGCollectionViewLayout *flowLayout = [AVGCollectionViewLayout new];
    flowLayout.delegate = self.feedDataProvider;
    self.feedCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.feedDataProvider.collectionView = self.feedCollectionView;
    self.feedCollectionView.backgroundColor = UIColor.customLightHoarColor;
    self.feedCollectionView.delegate = self.feedDataProvider;
    self.feedCollectionView.dataSource = self.feedDataProvider;
    [self.feedCollectionView registerClass:[AVGFeedCollectionViewCell class] forCellWithReuseIdentifier:flickrCellIdentifier];
    [self.view addSubview:self.feedCollectionView];
    
    UIView *superview = self.view;
    [self.feedCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(0.5);
        make.left.equalTo(superview).with.offset(0.5);
        make.right.equalTo(superview).with.offset(-0.5);
        make.bottom.equalTo(superview).with.offset(-0.5);
    }];
}

#pragma mark - SearchBar configuration

- (void)configurateSearchBar {
    // SearchBar
    CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40.f);
    self.searchBar = [[UISearchBar alloc] initWithFrame:bounds];
    self.feedDataProvider.searchBar = self.searchBar;
    self.searchBar.delegate = self.feedDataProvider;
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    self.searchBar.placeholder = @"Поиск";
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - Settings button configuration

- (void)configurateOptionsButton {
    UIImage *optionsImage = [UIImage imageNamed:@"icSettings"];
    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithImage:optionsImage
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(optionsButtonAction:)];
    optionsButton.tintColor = UIColor.blackColor;
    self.navigationItem.rightBarButtonItem = optionsButton;
}

#pragma mark - Actions

- (void)optionsButtonAction:(UIBarButtonItem *)sender {
    AVGSettingsViewController *settingsViewController = [AVGSettingsViewController new];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end
