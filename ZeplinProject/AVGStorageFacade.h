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
 Фасад для сохранения картинки на диск и информации о ней в кор дату
 
 @param image Картинка
 @param imageInfo Информация о картинке
 */
- (void)saveImage:(UIImage *)image withImageInformation:(AVGDetailedImageInformation *)imageInfo;

/**
 Метод возвращаюший массив картинок с информацией о них

 @return NSArray, внутри NSDictionaries, каждый NSDictionary содержит @{@"image":UIImage, @"imageInformation":AVGDetailedInformation}
 */
- (NSArray *)getImagesWithInformation;

@end
