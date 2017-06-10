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

@interface AVGFeedViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AVGImageServiceDelegate>

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

- (instancetype)init {
    self = [super init];
    if (self) {
        UITabBarItem *tabBar = [[UITabBarItem alloc] initWithTitle:@"Лента" image:[UIImage imageNamed:@"icFeed"] tag:0];
        self.tabBarItem = tabBar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // Options navigation button
    UIImage *optionsImage = [UIImage imageNamed:@"icSettings"];
    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithImage:optionsImage
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(optionsButtonAction:)];
    optionsButton.tintColor = UIColor.blackColor;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    // Services
    self.urlService = [AVGUrlService new];
    self.imageCache = [NSCache new];
    _imageCache.countLimit = 50;
    self.imageServices = [NSMutableArray new];
    self.isLoading = YES;
    _isLoadingBySearch = YES;
    
    // SearchBar
    CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40.f);
    self.searchBar = [[UISearchBar alloc] initWithFrame:bounds];
    self.searchBar.delegate = self;
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    self.searchBar.placeholder = @"Поиск";
    
    self.navigationItem.titleView = self.searchBar;
    
    // CollectionView
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    self.feedCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.feedCollectionView.backgroundColor = UIColor.whiteColor;
    //self.feedCollectionView.collectionViewLayout = flowLayout;
    self.feedCollectionView.delegate = self;
    self.feedCollectionView.dataSource = self;
    [self.feedCollectionView registerClass:[AVGFeedCollectionViewCell class] forCellWithReuseIdentifier:flickrCellIdentifier];
    [self.view addSubview:self.feedCollectionView];
}

#pragma mark - Download when scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!_isLoading) {
            _isLoading = YES;
            //self.tableView.tableFooterView.hidden = NO;
            //[_indicatorFooter startAnimating];
            [self loadImages];
        }
    }
}

#pragma mark - Page loading (AVGImageService.m contains variable how many images load per page)

- (void)loadImages {
    _isLoadingBySearch = NO;
    _page++;
    
    [_urlService loadInformationWithText:_searchText forPage:_page];
    [_urlService parseInformationWithCompletionHandler:^(NSArray *imageUrls) {
        
        [_arrayOfImagesInformation addObjectsFromArray:[imageUrls mutableCopy]];
        NSUInteger countOfImages = [imageUrls count];
        for (NSUInteger i = 0; i < countOfImages; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [_imageServices addObject:imageService];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray *arrayOfIndexPathes = [[NSMutableArray alloc] init];
            
            for(int i = (int)[_arrayOfImagesInformation count] - (int)[imageUrls count]; i < [_arrayOfImagesInformation count]; ++i){
                
                [arrayOfIndexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            //self.tableView.tableFooterView.hidden = YES;
            //[_indicatorFooter stopAnimating];
            
            /*
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:arrayOfIndexPathes withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
             */
            [self.feedCollectionView reloadData];
            [self.searchBar endEditing:YES];
            _isLoading = NO;
        });
    }];
    
}

#pragma mark - Actions

- (void)optionsButtonAction:(UIBarButtonItem *)sender {
    
}

#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrayOfImagesInformation count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)([collectionView dequeueReusableCellWithReuseIdentifier:flickrCellIdentifier forIndexPath:indexPath]);
    
    AVGImageService *imageService = _imageServices[indexPath.row];
    AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
    UIImage *cachedImage = [_imageCache objectForKey:imageInfo.url];
    
    if (cachedImage) {
        //[cell.searchedImageView.activityIndicatorView stopAnimating];
        //cell.searchedImageView.progressView.hidden = YES;
        //cell.searchedImageView.image = cachedImage;
        cell.imageView.image = cachedImage;
    } else {
        //cell.delegate = self;
        imageService.delegate = self;
        imageService.imageState = AVGImageStateNormal;
        [imageService loadImageFromUrlString:imageInfo.url andCache:self.imageCache forRowAtIndexPath:(NSIndexPath *)indexPath];
    }
    
    if (imageService.imageState == AVGImageStateBinarized) {
        //cell.filterButton.enabled = NO;
    } else {
        //cell.filterButton.enabled = YES;
    }

    
    // Configure the cell
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(self.view.bounds) / 3.f) - 14.f;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1.f, 1.f, 1.f, 1.f);
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
    //[UIView animateWithDuration:1.f animations:^{
        [searchBar resignFirstResponder];
    //}];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [_imageServices removeAllObjects];
    _page = 1;
    _isLoadingBySearch = YES;
    
    _searchText = searchBar.text;
    
    [_urlService loadInformationWithText:_searchText forPage:_page];
    [_urlService parseInformationWithCompletionHandler:^(NSArray *imageUrls) {
        
        _arrayOfImagesInformation = [imageUrls mutableCopy];
        NSUInteger countOfImages = [imageUrls count];
        for (NSUInteger i = 0; i < countOfImages; i++) {
            AVGImageService *imageService = [AVGImageService new];
            [_imageServices addObject:imageService];
        }
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            /*
            [self.tableView beginUpdates];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
             */
            [self.feedCollectionView reloadData];
            [self.searchBar endEditing:YES];
            _isLoading = NO;
        });
    }];
}

#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFlickrCell *cell = (AVGFlickrCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.searchedImageView.progressView.hidden = NO;
        cell.searchedImageView.activityIndicatorView.hidden = NO;
        cell.searchedImageView.progressView.progress = 0.f;
        [cell.searchedImageView.activityIndicatorView startAnimating];
    });
     */
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFlickrCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.searchedImageView.progressView.progress = progress;
    });
     */
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (image) {
            AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.feedCollectionView cellForItemAtIndexPath:indexPath];
            cell.imageView.image = image;
            //[cell.searchedImageView.activityIndicatorView stopAnimating];
           // cell.searchedImageView.progressView.hidden = YES;
            [cell setNeedsLayout];
        }
    });
    
}

- (void)service:(AVGImageService *)service binarizedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
   /* dispatch_async(dispatch_get_main_queue(), ^{
        if (image) {
            AVGFlickrCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.filterButton.enabled = NO;
            
            [UIView animateWithDuration:0.3f animations:^{
                cell.searchedImageView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3f animations:^{
                    cell.searchedImageView.image = image;
                    cell.searchedImageView.alpha = 1.f;
                }];
            }];
            [cell setNeedsLayout];
        }
    });*/
}


@end
