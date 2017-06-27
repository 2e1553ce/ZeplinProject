//
//  AVGUrlContainer.m
//  FlickerImages
//
//  Created by aiuar on 28.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGUrlContainer.h"

@implementation AVGUrlContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return self;
}

@end
