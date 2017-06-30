//
//  AVGFolderStorageService.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@interface AVGFolderStorageService : NSObject

/**
 Метод сохраняющий картинку на диск

 @param image Картинка
 @param identifier Идентификатор картинки
 @return Путь на диске, куда сохранили картинку
 */
- (NSString *)saveImage:(UIImage *)image withID:(NSString *)identifier;

/**
 Метод возвращающий картинку, сохраненнию на диске

 @param imagePath Путь на диске
 @return UIImage Картинка
 */
- (UIImage *)getImageFrom:(NSString *)imagePath;

@end
