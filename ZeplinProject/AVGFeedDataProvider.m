//
//  AVGFeedDataProvider.m
//  ZeplinProject
//
//  Created by aiuar on 29.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFeedDataProvider.h"
#import "AVGFeedCollectionViewCell.h"
#import "AVGImageService.h"
#import "AVGImageInformation.h"
#import "AVGCollectionViewLayout.h"
#import "AVGDetailedViewController.h"
#import "AVGUrlService.h"

@interface AVGFeedDataProvider ()

@end

@implementation AVGFeedDataProvider

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
    if (state == AVGImageProgressStateDownloading) { // &&isLoading by search
        [service cancel];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    // Изза кастомного леяута в cellForRowAtIndexPath немного смещаются индексы, поэтому тут
    AVGFeedCollectionViewCell *feedCell = (AVGFeedCollectionViewCell*)cell;
    AVGImageService *imageService = _imageServices[indexPath.row];
    AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
    UIImage *cachedImage = [_imageCache objectForKey:imageInfo.url];
    
    if (cachedImage) {
        [feedCell.activityIndicatorView stopAnimating];
        feedCell.progressView.hidden = YES;
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
    if (indexPath.row % 12 == 0 || indexPath.row % 12 == 7) {
        CGFloat width = (((CGRectGetWidth(self.collectionView.bounds)) / 3.f) * 2);
        return width;
    }
    // Small frame
    else {
        CGFloat width = (CGRectGetWidth(self.collectionView.bounds)) / 3.f;
        return width;
    }
}

- (UIEdgeInsets)collectionLayout:(AVGCollectionViewLayout *)layout edgeInsetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0.5f, 0.5f, 0.5f, 0.5f);
}

- (NSInteger)countOfItems {
    return [self.collectionView numberOfItemsInSection:0];
}

- (CGFloat)lowerestCellWidth {
    return (CGRectGetWidth(self.collectionView.bounds)) / 3.f;
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
            [self.collectionView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            [self.searchBar endEditing:YES];
            self.isLoading = NO;
        });
    }];
}

#pragma mark - AVGImageServiceDelegate

- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.progressView.hidden = NO;
        cell.activityIndicatorView.hidden = NO;
        cell.progressView.progress = 0.f;
        [cell.activityIndicatorView startAnimating];
    });
    
}

- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.progressView.progress = progress;
    });
    
}

- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (image) {
            AVGImageInformation *imageInfo = _arrayOfImagesInformation[indexPath.row];
            [_imageCache setObject:image forKey:imageInfo.url];
            AVGFeedCollectionViewCell *cell = (AVGFeedCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.searchedImageView.image = image;
            [cell.activityIndicatorView stopAnimating];
            cell.progressView.hidden = YES;
            [cell setNeedsLayout];
        }
    });
}

@end
