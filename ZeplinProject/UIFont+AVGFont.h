//
//  UIFont+AVGFont.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (AVGFont)

@property (class, nonatomic, readonly) UIFont *imageDescription;
@property (class, nonatomic, readonly) UIFont *imageLocation;
@property (class, nonatomic, readonly) UIFont *nickName;
@property (class, nonatomic, readonly) UIFont *comment;

+ (UIFont *)imageDescription;
+ (UIFont *)imageLocation;
+ (UIFont *)nickName;
+ (UIFont *)comment;

@end
