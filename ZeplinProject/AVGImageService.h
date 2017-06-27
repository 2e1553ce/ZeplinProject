//
//  AVGImageService.h
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGLoadImageOperation.h"

@class AVGImageService;

typedef NS_ENUM(NSInteger, AVGImageState) {
    AVGImageStateNormal = 0,
    AVGImageStateBinarized
};

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

@interface AVGImageService : NSObject

@property (nonatomic, assign) AVGImageState imageState;
@property (nonatomic, weak) id<AVGImageServiceDelegate> delegate;

/**
 Method load image from urlString and cache it

 @param urlString Image url
 @param cache Cache for image
 @param indexPath Indexpath of cell
 */
- (void)loadImageFromUrlString:(NSString *)urlString
                      andCache:(NSCache *)cache
             forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Method binarize image

 @param indexPath Indexpath of cell
 */
- (void)filterImageforRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Method for getting image state

 @return state of image - normal or binarized
 */
- (AVGImageProgressState)imageProgressState;

/**
 Method pausing image download
 */
- (void)pause;

/**
 Method canceling image download
 */
- (void)cancel;

@end
