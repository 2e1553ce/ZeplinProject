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
 Метод для загрузки информации о фотографиях, из которых собираются url'ы к ним

 @param text Поисковый запрос
 @param page Для постраничной загрузки
 */
- (void)loadInformationWithText:(NSString *)text
                        forPage:(NSInteger)page;

/**
 Метод парсит полученную информацию о фотографиях

 @param completion Колбек для апдейта UI
 */
- (void)parseInformationWithCompletionHandler:(void(^)(NSArray *imageUrls))completion;

@end
