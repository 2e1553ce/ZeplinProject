//
//  AVGLoadImageOperation.h
//  FlickerImages
//
//  Created by aiuar on 24.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGLoadParseContainer;

typedef NS_ENUM(NSInteger, AVGImageProgressState) {
    AVGImageProgressStateNew = 0,
    AVGImageProgressStateDownloading,
    AVGImageProgressStatePaused,
    AVGImageProgressStateDownloaded,
    AVGImageProgressStateCancelled
};

typedef void (^downloadProgressBlock)(float progress);

@interface AVGLoadImageOperation : NSOperation

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) downloadProgressBlock downloadProgressBlock;
@property (nonatomic, assign) AVGImageProgressState imageProgressState;
@property (nonatomic, strong) AVGLoadParseContainer *operationDataContainer;

/**
 Method resume image download
 */
- (void)resumeDownload;

/**
 Method pause image download
 */
- (void)pauseDownload;

/**
 Method cancel image download
 */
- (void)cancelDownload;

/**
 Initialization

 @return Self
 */
- (instancetype)init;

/**
 Designited initializator

 @param urlString Url for image load
 @return Self
 */
- (instancetype)initWithUrlString:(NSString *)urlString NS_DESIGNATED_INITIALIZER;

@end
