//
//  AVGDetailedImageService.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGDetailedImageInformation;

@interface AVGDetailedImageService : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithImageID:(NSString *)imageID NS_DESIGNATED_INITIALIZER;

/**
 Метод загружающий полную информацию о картинке по ее ID

 @param completion Колбек с информацией о картинке
 */
- (void)getImageInformationWithCompletionHandler:(void (^)(AVGDetailedImageInformation *info))completion;

@end
