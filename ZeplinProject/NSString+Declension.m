//
//  NSString+Declension.m
//  ZeplinProject
//
//  Created by aiuar on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "NSString+Declension.h"

@implementation NSString (Declension)

#pragma mark - Declension string

+ (NSString *)declensionStringFor:(AVGDeclensionType)type andCount:(NSInteger)count {
    switch (type) {
        case AVGDeclensionTypeComment: {
            NSString *declensionedString;
            if (count % 100 == 11) {
                declensionedString = @"комментариев";
            } else if (count % 10 == 1) {
                declensionedString = @"комментарий";
            } else if (count % 10 > 1 && count % 10 < 5) {
                declensionedString = @"комментария";
            } else {
                declensionedString = @"комментариев";
            }
            return declensionedString;
        }
        case AVGDeclensionTypeLike: {
            NSString *declensionedString;
            if (count % 100 == 11) {
                declensionedString = @"лайков";
            } else if (count % 10 == 1) {
                declensionedString = @"лайк";
            } else if (count % 10 > 1 && count % 10 < 5) {
                declensionedString = @"лайка";
            } else {
                declensionedString = @"лайков";
            }
            return declensionedString;
        }
    }
}

@end
