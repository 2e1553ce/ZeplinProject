//
//  AVGFolderStorageService.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@interface AVGFolderStorageService : NSObject

/**
 Method saving UIImage to disk

 @param image UIImage
 @param identifier UIImage identifier from Flickr
 @return Folder path where image was saved
 */
- (NSString *)saveImage:(UIImage *)image withID:(NSString *)identifier;

/**
 Method getting image from disk

 @param imagePath Image path on disk
 @return UIImage from disk
 */
- (UIImage *)getImageFrom:(NSString *)imagePath;

@end
