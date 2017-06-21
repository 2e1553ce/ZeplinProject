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
#import "AVGLoadLikesOperation.h"
#import "AVGLoadCommentsOperation.h"
#import "AVGParseInformationOperation.h"
#import "AVGDetailedInformationContainer.h"

@interface AVGDetailedImageService ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) AVGLoadInformationOperation *informationOperation;
@property (nonatomic, strong) AVGLoadLikesOperation *likesOperation;
@property (nonatomic, strong) AVGLoadCommentsOperation *commentsOperation;
@property (nonatomic, strong) AVGParseInformationOperation *parseOperation;

@property (nonatomic, strong) AVGDetailedInformationContainer *operationContainer;

@end

@implementation AVGDetailedImageService

- (instancetype)initWithImageID:(NSString *)imageID {
    self = [super init];
    if (self) {
        self.queue = [NSOperationQueue new];
        self.operationContainer = [AVGDetailedInformationContainer new];
        self.operationContainer.imageID = imageID;
        
        self.informationOperation = [AVGLoadInformationOperation new];
        self.informationOperation.container = self.operationContainer;
        self.likesOperation = [AVGLoadLikesOperation new];
        self.likesOperation.container = self.operationContainer;
        self.commentsOperation = [AVGLoadCommentsOperation new];
        self.commentsOperation.container = self.operationContainer;
        self.parseOperation = [AVGParseInformationOperation new];
        self.parseOperation.container = self.operationContainer;
        
        [self.likesOperation addDependency:self.informationOperation];
        [self.commentsOperation addDependency:self.likesOperation];
        [self.parseOperation addDependency:self.commentsOperation];
    }
    
    return  self;
}

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
