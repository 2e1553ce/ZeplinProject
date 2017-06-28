//
//  AVGStorageFacade.m
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGStorageFacade.h"
#import "AVGCoreDataService.h"
#import "AVGFolderStorageService.h"
#import "AVGDetailedImageInformation.h"

@interface AVGStorageFacade ()

@property (nonatomic, strong) AVGCoreDataService *coreDataService;
@property (nonatomic, strong) AVGFolderStorageService *folderStorageService;

@end

@implementation AVGStorageFacade

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _coreDataService = [AVGCoreDataService new];
        _folderStorageService = [AVGFolderStorageService new];
    }
    return self;
}

#pragma mark - Saving image

- (void)saveImage:(UIImage *)image withImageInformation:(AVGDetailedImageInformation *)imageInfo {
    NSString *path = [self.folderStorageService saveImage:image withID:imageInfo.identifier];
    [self.coreDataService saveImageInformation:imageInfo andFolderPath:path];
}

#pragma mark - Getting images

- (NSArray *)getImagesWithInformation {
    NSArray *imagesInfo = [self.coreDataService getImagesInformation];
    NSMutableArray *resultArray = [NSMutableArray new];
    
    for (AVGDetailedImageInformation *detailedInfo in imagesInfo) {
        NSString *path = detailedInfo.folderPath;
        UIImage *image = [self.folderStorageService getImageFrom:path];
        if (image) {
            NSDictionary *dict = @{@"imageInformation":detailedInfo, @"image": image};
            [resultArray addObject:dict];
        }
    }
    
    return [resultArray copy];
}

@end
