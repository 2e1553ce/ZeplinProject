//
//  AVGFeedDataProvider.h
//  ZeplinProject
//
//  Created by aiuar on 29.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGImageService.h"
#import "AVGCollectionViewLayout.h"
@class AVGImageService, AVGImageInformation, AVGUrlService;

@interface AVGFeedDataProvider : NSObject <UICollectionViewDataSource, UISearchBarDelegate, AVGCollectionViewLayoutDelegate, AVGImageServiceDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UINavigationController *navigationController;

@end
