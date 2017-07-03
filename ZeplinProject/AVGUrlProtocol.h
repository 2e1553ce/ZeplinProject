//
//  AVGUrlProtocol.h
//  ZeplinProject
//
//  Created by aiuar on 01.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@protocol AVGUrlProtocol <NSObject>

/**
 Метод для загрузки информации о фотографиях, из которых собираются url'ы к ним
 
 @param text Поисковый запрос
 @param page Для постраничной загрузки
 */
- (void)loadInformationWithText:(NSString *)text
                        forPage:(NSInteger)page;

/**
 Метод парсит полученную информацию о фотографиях
 
 @param completion Возвращает url'ы
 */
- (void)parseInformationWithCompletionHandler:(void(^)(NSArray *imageUrls))completion;

@end
