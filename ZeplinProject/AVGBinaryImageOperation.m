//
//  AVGBinaryImageOperation.m
//  FlickerImages
//
//  Created by aiuar on 24.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGBinaryImageOperation.h"
#import "AVGLoadParseContainer.h"

@implementation AVGBinaryImageOperation

#pragma mark - Binarization

- (void)main {
    if (self.operationDataContainer) {
        CGRect imageRect = CGRectMake(0, 0, self.operationDataContainer.image.size.width, self.operationDataContainer.image.size.height);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, self.operationDataContainer.image.size.width, self.operationDataContainer.image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        CGContextDrawImage(context, imageRect, [self.operationDataContainer.image CGImage]);
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        self.operationDataContainer.image = [UIImage imageWithCGImage:imageRef];
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CFRelease(imageRef); // could be leak
    }
}

@end
