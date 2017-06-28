//
//  AVGCoreDataService.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGDetailedImageInformation;

@interface AVGCoreDataService : NSObject

/**
 Method saving detailed image information and folderPath for image

 @param imageInfo AVGDetailedImageInfo
 @param folderPath Folder path on disk
 */
- (void)saveImageInformation:(AVGDetailedImageInformation *)imageInfo andFolderPath:(NSString *)folderPath;

/**
 Method getting image info and folder path

 @return NSArray of AVGDetailedImageInformation
 */
- (NSArray *)getImagesInformation;

@end
