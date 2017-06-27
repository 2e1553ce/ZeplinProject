//
//  AVGLoadInformationOperation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

typedef NS_ENUM(NSInteger, AVGURLMethodType) {
    AVGURLMethodTypeInfo,
    AVGURLMethodTypeFavorites,
    AVGURLMethodTypeComments
};

@class AVGDetailedInformationContainer;

@interface AVGLoadInformationOperation : NSOperation

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) AVGDetailedInformationContainer *container;
@property (nonatomic, assign) AVGURLMethodType method;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

/**
 Initializator by URL method for gettiong info about image/imageLikes/imageComments

 @param method Type of method
 @return Self
 */
- (instancetype)initWithMethod:(AVGURLMethodType)method NS_DESIGNATED_INITIALIZER;

@end
