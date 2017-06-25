//
//  AVGLoadInformationOperation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AVGURLMethodType) {
    AVGURLMethodTypeInfo,
    AVGURLMethodTypeFavorites,
    AVGURLMethodTypeComments
};

@class AVGDetailedInformationContainer;

@interface AVGLoadInformationOperation : NSOperation

@property (nonatomic, strong) AVGDetailedInformationContainer *container;
@property (nonatomic, assign) AVGURLMethodType method;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithMethod:(AVGURLMethodType)method NS_DESIGNATED_INITIALIZER;

@end
