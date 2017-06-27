//
//  UIFont+AVGFont.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@interface UIFont (AVGFont)

@property (class, nonatomic, readonly) UIFont *imageDescription;
@property (class, nonatomic, readonly) UIFont *imageLocation;
@property (class, nonatomic, readonly) UIFont *nickName;
@property (class, nonatomic, readonly) UIFont *comment;
@property (class, nonatomic, readonly) UIFont *settingsTitle;

+ (UIFont *)imageDescription;
+ (UIFont *)imageLocation;
+ (UIFont *)nickName;
+ (UIFont *)comment;
+ (UIFont *)settingsTitle;

@end
