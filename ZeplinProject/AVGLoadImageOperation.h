//
//  AVGLoadImageOperation.h
//  FlickerImages
//
//  Created by aiuar on 24.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGLoadBinarizeContainer;

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
@property (nonatomic, strong) AVGLoadBinarizeContainer *operationDataContainer;

/**
 Метод возобновляющий загрузку
 */
- (void)resumeDownload;

/**
 Метод приостанавливающий загрузку
 */
- (void)pauseDownload;

/**
 Метод отменяющий загрузку
 */
- (void)cancelDownload;

/**
 Инициализация

 @return Self
 */
- (instancetype)init;

/**
 Назначенный инициализатор

 @param urlString Url для загрузки картинки
 @return Self
 */
- (instancetype)initWithUrlString:(NSString *)urlString NS_DESIGNATED_INITIALIZER;

@end
