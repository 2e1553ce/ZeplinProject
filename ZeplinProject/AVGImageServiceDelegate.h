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
 Метод уведомляет о начале загрузки, включаем активити индикаторы
 
 @param service Ссылка на себя
 @param indexPath Индекс ячейки которую апдейтим
 */
- (void)serviceStartedImageDownload:(AVGImageService *)service forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 Метод для апдейта прогресс бара на ячейках которые грузят картинку
 
 @param service Ссылка на себя
 @param progress Сколько скачалось
 @param indexPath Индекс ячейки
 */
- (void)service:(AVGImageService *)service updateImageDownloadProgress:(float)progress forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 Метод уведомляет о конце загрузки картинки, сбрасываем индикаторы
 
 @param service Ссылка на себя
 @param image Скаченная картинка
 @param indexPath Индекс ячейки
 */
- (void)service:(AVGImageService *)service downloadedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath;

@optional

/**
 Метод для передачи контроллеру обработанной картинки
 
 @param service Ссылка на себя
 @param image Обработанная картинка
 @param indexPath Индекс ячейки
 */
- (void)service:(AVGImageService *)service binarizedImage:(UIImage *)image forRowAtIndexPath:(NSIndexPath*)indexPath;

@end
