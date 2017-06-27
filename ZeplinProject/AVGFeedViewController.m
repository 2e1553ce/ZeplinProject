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

@interface AVGFeedViewController () <UISearchBarDelegate, UICollectionViewDataSource, AVGCollectionViewLayoutDelegate, AVGImageServiceDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy)   NSString *searchText;
@property (nonatomic, strong) UICollectionView *feedCollectionView;

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
    }
    return self;
}

#pragma mark - Life cycle of viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.customLightHoarColor;
    
    // Services
    self.urlService = [AVGUrlService new];
    self.imageServices = [NSMutableArray new];
    self.imageCache = [NSCache new];
    self.imageCache.countLimit = 50;
    self.isLoading = NO;
    self.isLoadingBySearch = YES;
    
    // Options button at top-right corner
    [self configurateOptionsButton];
    // SearchBar
    [self configurateSearchBar];
    // Collection view
    [self configurateColectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Collection view configuration

- (void)configurateColectionView {
    // CollectionView
    AVGCollectionViewLayout *flowLayout = [AVGCollectionViewLayout new];
    flowLayout.delegate = self;
    self.feedCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.feedCollectionView.backgroundColor = UIColor.customLightHoarColor;
    self.feedCollectionView.delegate = self;
    self.feedCollectionView.dataSource = self;
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
    self.searchBar.delegate = self;
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    self.searchBar.placeholder = @"Поиск";
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - Options button configuration

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

#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrayOfImagesInformation count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AVGFeedCollectionViewCell *cell = ([collectionView dequeueReusableCellWithReuseIdentifier:flickrCellIdentifier forIndexPath:indexPath]);
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    AVGImageService *service = _imageServices[indexPath.row];
    AVGImageProgressState state = [service imageProgressState];
    if (state == AVGImageProgressStateDownloading && !_isLoadingBySearch) {
        //[service cancel];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    // Изза кастомного леяута в cellForRowAtIndexPath немного смещаются индексы, поэтому тут
    AVGFeedCollectionViewCell *feedCell = (AVGFeedCollectionViewCell*)cell;
    AVGImageService *imageService = _imageServices[indexPath.row];
    AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
    UIImage *cachedImage = [_imageCache objectForKey:imageInfo.url];
    
    if (cachedImage) {
        [feedCell.searchedImageView.activityIndicatorView stopAnimating];
        feedCell.searchedImageView.progressView.hidden = YES;
        feedCell.searchedImageView.image = cachedImage;
    } else {
        imageService.delegate = self;
        imageService.imageState = AVGImageStateNormal;
        [imageService loadImageFromUrlString:imageInfo.url andCache:self.imageCache forRowAtIndexPath:(NSIndexPath *)indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
    UIImage *cachedImage = [_imageCache objectForKey:imageInfo.url];
    if (cachedImage) {
        AVGDetailedViewController *detailedViewController = [AVGDetailedViewController new];
        detailedViewController.image = cachedImage;
        detailedViewController.imageID = imageInfo.imageID;
        [self.navigationController pushViewController:detailedViewController animated:YES];
    }
}

#pragma mark - AVGCollectionViewLayoutDelegate

- (CGFloat)collectionLayout:(AVGCollectionViewLayout *)layout preferredWidthForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Big frame
    if (indexPath.row % 6 == 0 || indexPath.row == 0) {
        CGFloat width = (((CGRectGetWidth(self.feedCollectionView.bounds)) / 3.f) * 2);
        return width;
    }
    // Small frame
    else {
        CGFloat width = (CGRectGetWidth(self.feedCollectionView.bounds)) / 3.f;
        return width;
    }
}

- (UIEdgeInsets)collectionLayout:(AVGCollectionViewLayout *)layout edgeInsetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0.5f, 0.5f, 0.5f, 0.5f);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:1.f animations:^{
        searchBar.showsCancelButton = NO;
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    self.page = 1;
    self.isLoadingBySearch = YES;
    self.searchText = searchBar.text;
    
    [self.urlService loadInformationWithText:_searchText forPage:self.page];
    [self.urlService parseInformationWithCompletionHandler:^(NSArray *imageUrls) {
        self.arrayOfImagesInformation = [imageUrls mutableCopy];
        NSUInteger countOfImages = [imageUrls count];
        [self.imageServices removeAllObjects];
        for (NSUInteger i = 0; i < countOfImages; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [self.imageServices addObject:imageService];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedCollectionView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.feedCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            [self.searchBar endEditing:YES];
            self.isLoading = NO;
        });
    }];
}

#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.feedCollectionView cellForItemAtIndexPath:indexPath];
        cell.searchedImageView.progressView.hidden = NO;
        cell.searchedImageView.activityIndicatorView.hidden = NO;
        cell.searchedImageView.progressView.progress = 0.f;
        [cell.searchedImageView.activityIndicatorView startAnimating];
    });
    
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.feedCollectionView cellForItemAtIndexPath:indexPath];
        cell.searchedImageView.progressView.progress = progress;
    });
    
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (image) {
            AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
            [_imageCache setObject:image forKey:imageInfo.url];
            AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.feedCollectionView cellForItemAtIndexPath:indexPath];
            cell.searchedImageView.image = image;
            [cell.searchedImageView.activityIndicatorView stopAnimating];
            cell.searchedImageView.progressView.hidden = YES;
            [cell setNeedsLayout];
        }
    });
}

@end
