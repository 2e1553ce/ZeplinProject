//
//  AVGImageService.h
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGLoadImageOperation.h"
#import "AVGImageServiceDelegate.h"

typedef NS_ENUM(NSInteger, AVGImageState) {
    AVGImageStateNormal = 0,
    AVGImageStateBinarized
};

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
