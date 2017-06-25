//
//  UIColor+AVGColor.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AVGColor)

@property (class, nonatomic, readonly) UIColor *customLightGrayColor;
@property (class, nonatomic, readonly) UIColor *customLightBlueColor;

+ (UIColor *)customLightGrayColor;
+ (UIColor *)customLightBlueColor;

@end
