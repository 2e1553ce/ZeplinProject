//
//  UIFont+AVGFont.m
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "UIFont+AVGFont.h"

@implementation UIFont (AVGFont)

// Нужно ли объединять? А если измениться у какого-то одного размер или стиль?
+ (UIFont *)imageDescription {
    UIFont *font = [UIFont systemFontOfSize:14];
    return font;
}

+ (UIFont *)nickName {
    UIFont *font = [UIFont systemFontOfSize:14];
    return font;
}

+ (UIFont *)imageLocation {
    UIFont *font = [UIFont systemFontOfSize:13];
    return font;
}

+ (UIFont *)comment {
    UIFont *font = [UIFont systemFontOfSize:13];
    return font;
}

+ (UIFont *)settingsTitle {
    UIFont *font = [UIFont systemFontOfSize:17];
    return font;
}

@end
