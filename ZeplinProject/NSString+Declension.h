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
 Method for getting declension of NSString with AVGDeclensionType type

 @param type Enum AVGDeclensionType
 @param count Count for declension
 @return Declensioned string
 */
+ (NSString *)declensionStringFor:(AVGDeclensionType)type andCount:(NSInteger)count;

@end
