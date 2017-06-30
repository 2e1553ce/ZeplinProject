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
 Метод для загрузки картинки по url

 @param urlString Url картинки
 @param cache Кэш
 @param indexPath Индекс ячейки
 */
- (void)loadImageFromUrlString:(NSString *)urlString
                      andCache:(NSCache *)cache
             forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Метод накладывающий фильтр на картинку

 @param indexPath Индекс ячейки
 */
- (void)filterImageforRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Метод для получения стейта картинки

 @return Стейт картинки - нормальная / фильтрованная
 */
- (AVGImageProgressState)imageProgressState;

/**
 Метод приостанавливает загрузку картинки
 */
- (void)pause;

/**
 Метод отменяет загрузку картинки
 */
- (void)cancel;

@end
