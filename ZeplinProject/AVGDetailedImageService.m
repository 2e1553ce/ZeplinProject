//
//  AVGDetailedImageService.m
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedImageService.h"
#import "AVGDetailedImageInformation.h"
#import "AVGCommentator.h"
#import "AVGLoadInformationOperation.h"
#import "AVGParseInformationOperation.h"
#import "AVGDetailedInformationContainer.h"

@interface AVGDetailedImageService ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) AVGLoadInformationOperation *informationOperation;
@property (nonatomic, strong) AVGLoadInformationOperation *likesOperation;
@property (nonatomic, strong) AVGLoadInformationOperation *commentsOperation;
@property (nonatomic, strong) AVGParseInformationOperation *parseOperation;
@property (nonatomic, strong) AVGDetailedInformationContainer *operationContainer;

@end

@implementation AVGDetailedImageService

#pragma mark - Initialization

- (instancetype)initWithImageID:(NSString *)imageID {
    self = [super init];
    if (self) {
        _queue = [NSOperationQueue new];
        _operationContainer = [AVGDetailedInformationContainer new];
        _operationContainer.imageID = imageID;
        
        _informationOperation = [[AVGLoadInformationOperation alloc] initWithMethod:AVGURLMethodTypeInfo];
        _informationOperation.container = _operationContainer;
        _informationOperation.session = _operationContainer.session;
        
        _likesOperation = [[AVGLoadInformationOperation alloc] initWithMethod:AVGURLMethodTypeFavorites];
        _likesOperation.container = _operationContainer;
        _likesOperation.session = _operationContainer.session;
        
        _commentsOperation = [[AVGLoadInformationOperation alloc] initWithMethod:AVGURLMethodTypeComments];
        _commentsOperation.container = _operationContainer;
        _commentsOperation.session = _operationContainer.session;
        
        _parseOperation = [AVGParseInformationOperation new];
        _parseOperation.container = _operationContainer;
        
        [_likesOperation addDependency:_informationOperation];
        [_commentsOperation addDependency:_likesOperation];
        [_parseOperation addDependency:_commentsOperation];
    }
    
    return  self;
}

#pragma mark - Get image info

- (void)getImageInformationWithCompletionHandler:(void (^)(AVGDetailedImageInformation *info))completion {
    [self.queue addOperation:self.informationOperation];
    [self.queue addOperation:self.likesOperation];
    [self.queue addOperation:self.commentsOperation];
    [self.queue addOperation:self.parseOperation];
    
    __weak typeof(self) weakSelf = self;
    self.parseOperation.completionBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            completion(strongSelf.operationContainer.information);
        }
    };
}

@end
