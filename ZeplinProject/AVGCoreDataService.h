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
 Метод сохраняет детальную информацию о картинке и путь на диске

 @param imageInfo AVGDetailedImageInfo
 @param folderPath Путь на диске
 */
- (void)saveImageInformation:(AVGDetailedImageInformation *)imageInfo andFolderPath:(NSString *)folderPath;

/**
 Метод возвращающий информацию по сохраненной картинке

 @return NSArray в котором AVGDetailedImageInformation
 */
- (NSArray *)getImagesInformation;

@end
