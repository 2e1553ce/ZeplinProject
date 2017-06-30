//
//  AVGFeedViewController.m
//  ZeplinProject
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFeedViewController.h"
#import "AVGImageService.h"
#import "AVGUrlService.h"
#import "AVGImageInformation.h"
#import "AVGFeedCollectionViewCell.h"
#import "AVGCollectionViewLayout.h"
#import "AVGDetailedViewController.h"
#import "AVGSettingsViewController.h"
#import "AVGFeedDataProvider.h"

@interface AVGFeedViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy)   NSString *searchText;
@property (nonatomic, strong) UICollectionView *feedCollectionView;
@property (nonatomic, strong) AVGFeedDataProvider *feedDataProvider;

@property (nonatomic, strong) NSCache *imageCache; // need service
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <AVGImageService *> *imageServices;
@property (nonatomic, strong) NSMutableArray <AVGImageInformation *> *arrayOfImagesInformation;
@property (nonatomic, strong) AVGUrlService *urlService;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isLoadingBySearch; // при втором и далее поиске(через серч бар) вызывает didEndDisplay и канселит загрузку

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
    
    // Services
    self.urlService = [AVGUrlService new];
    self.feedDataProvider.urlService = self.urlService;
    self.imageServices = [NSMutableArray new];
    self.feedDataProvider.imageServices = self.imageServices;
    self.imageCache = [NSCache new];
    self.feedDataProvider.imageCache = self.imageCache;
    self.imageCache.countLimit = 100;
    self.isLoading = NO;
    self.feedDataProvider.isLoading = self.isLoading;
    self.isLoadingBySearch = YES;
    self.feedDataProvider.isLoadingBySearch = self.isLoadingBySearch;
    
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

#pragma mark - Download when scrolling
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!_isLoading) {
            _isLoading = YES;
            //self.tableView.tableFooterView.hidden = NO;
            //[_indicatorFooter startAnimating];
            [self loadImages];
        }
    }
}*/

#pragma mark - Page loading (AVGImageService.m contains variable how many images load per page)

- (void)loadImages {
    self.isLoadingBySearch = NO;
    self.page++;
    
    [self.urlService loadInformationWithText:_searchText forPage:self.page];
    [self.urlService parseInformationWithCompletionHandler:^(NSArray *imageUrls) {
        
        [self.arrayOfImagesInformation addObjectsFromArray:[imageUrls mutableCopy]];
        NSUInteger countOfImages = [imageUrls count];
        for (NSUInteger i = 0; i < countOfImages; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [self.imageServices addObject:imageService];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray *arrayOfIndexPathes = [[NSMutableArray alloc] init];
            for(int i = (int)[self.arrayOfImagesInformation count] - (int)[imageUrls count]; i < [self.arrayOfImagesInformation count]; ++i){
                
                [arrayOfIndexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [self.feedCollectionView reloadSections:indexSet];
            [self.searchBar endEditing:YES];
            self.isLoading = NO;
        });
    }];
    
}

#pragma mark - Actions

- (void)optionsButtonAction:(UIBarButtonItem *)sender {
    AVGSettingsViewController *settingsViewController = [AVGSettingsViewController new];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end
