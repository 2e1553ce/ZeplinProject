//
//  AVGDetailedInformationProtocol.h
//  ZeplinProject
//
//  Created by aiuar on 01.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGDetailedImageInformation;

@protocol AVGDetailedInformationProtocol <NSObject>

/**
 Метод загружающий полную информацию о картинке по ее ID
 
 @param completion Колбек с информацией о картинке
 */
- (void)getImageInformationWithCompletionHandler:(void (^)(AVGDetailedImageInformation *info))completion;

@end
