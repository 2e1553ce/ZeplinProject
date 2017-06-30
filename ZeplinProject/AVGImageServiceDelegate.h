//
//  AVGImageServiceDelegate.h
//  ZeplinProject
//
//  Created by aiuar on 29.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGImageService;

@protocol AVGImageServiceDelegate <NSObject>

/**
 Method notificate download indicators of cell
 
 @param service Service
 @param indexPath Indexpath of cell
 */
- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 Method update progress bar of cell
 
 @param service Service
 @param progress Downloaded progress value
 @param indexPath Indexpath of cell
 */
- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 Method notificate cell when image downloaded
 so we can set it and hide indicators
 
 @param service Service
 @param image Downloaded image
 @param indexPath Indexpath of cell
 */
- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath;

@optional

/**
 Method for image binarization
 
 @param service Service
 @param image Binarized image
 @param indexPath Indexpath of cell where we will change normal image to binarized
 */
- (void)service:(AVGImageService *)service binarizedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath;

@end
