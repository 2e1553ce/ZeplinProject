//
//  NSString+Declension.h
//  ZeplinProject
//
//  Created by aiuar on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

typedef NS_ENUM(NSInteger, AVGDeclensionType){
    AVGDeclensionTypeComment,
    AVGDeclensionTypeLike
};

@interface NSString (Declension)

/**
 Метод для склонения в зависимости от количества комментариев/лайков

 @param type Enum AVGDeclensionType
 @param count Количество комментариев/лайков
 @return Строка, которую склоняли
 */
+ (NSString *)declensionStringFor:(AVGDeclensionType)type andCount:(NSInteger)count;

@end
