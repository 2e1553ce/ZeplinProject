//
//  AVGUrlService.h
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGImageInformation;

@interface AVGUrlService : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSArray <AVGImageInformation *> *imagesUrls;

/**
 Method loading information about images

 @param text Search query
 @param page Offset for page loading
 */
- (void)loadInformationWithText:(NSString *)text
                        forPage:(NSInteger)page;

/**
 Method parsing information about image like "url, imageID" for downloading thumbnails

 @param completion Callback for update UI
 */
- (void)parseInformationWithCompletionHandler:(void(^)(NSArray *imageUrls))completion;

@end
