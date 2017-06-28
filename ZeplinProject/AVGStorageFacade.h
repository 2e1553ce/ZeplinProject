//
//  AVGStorageFacade.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGDetailedImageInformation;

@interface AVGStorageFacade : NSObject

/**
 Facade for saving image on the disk and information about it to CoreData
 
 @param image Image
 @param imageInfo Information about image and image owner
 */
- (void)saveImage:(UIImage *)image withImageInformation:(AVGDetailedImageInformation *)imageInfo;

/**
 Getting Images from disk and information about it from CoreData

 @return NSArray contains NSDictionaries, each NSDictionary contains @{@"image":UIImage, @"imageInformation":AVGDetailedInformation}
 */
- (NSArray *)getImagesWithInformation;

@end
