//
//  UIColor+AVGColor.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@interface UIColor (AVGColor)

@property (class, nonatomic, readonly) UIColor *customLightGrayColor;
@property (class, nonatomic, readonly) UIColor *customLightBlueColor;
@property (class, nonatomic, readonly) UIColor *customMiddleRedColor;
@property (class, nonatomic, readonly) UIColor *customAzureColor;
@property (class, nonatomic, readonly) UIColor *customLightHoarColor;

+ (UIColor *)customLightGrayColor;
+ (UIColor *)customLightBlueColor;
+ (UIColor *)customMiddleRedColor;
+ (UIColor *)customAzureColor;
+ (UIColor *)customLightHoarColor;

@end
