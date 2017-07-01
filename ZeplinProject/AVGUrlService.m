//
//  AVGUrlService.m
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGUrlService.h"
#import "AVGLoadUrlOperation.h"
#import "AVGParseUrlOperation.h"
#import "AVGUrlContainer.h"

@interface AVGUrlService ()

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) AVGLoadUrlOperation *loadUrlsOperation;
@property (nonatomic, strong) AVGParseUrlOperation *parseUrlsOperation;

@property (nonatomic, strong) AVGUrlContainer *operationDataContainer;

@end

@implementation AVGUrlService

static NSInteger const perPage = 250;

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSOperationQueue new];
        _operationDataContainer = [AVGUrlContainer new];
    }
    return  self;
}

#pragma mark - AVGUrlProtocol

- (void)loadInformationWithText:(NSString *)text
                        forPage:(NSInteger)page {
    
    self.loadUrlsOperation = [AVGLoadUrlOperation new];
    self.loadUrlsOperation.container = self.operationDataContainer;
    self.loadUrlsOperation.session = self.operationDataContainer.session;
    self.loadUrlsOperation.searchText = text;
    self.loadUrlsOperation.page = page;
    self.loadUrlsOperation.perPage = perPage;
    
    self.parseUrlsOperation = [AVGParseUrlOperation new];
    self.parseUrlsOperation.container = self.operationDataContainer;
    [self.parseUrlsOperation addDependency:self.loadUrlsOperation];
    
    [self.queue cancelAllOperations];
    [self.queue addOperation:self.loadUrlsOperation];
}

- (void)parseInformationWithCompletionHandler:(void(^)(NSArray *imageUrls))completion {
    [self.queue addOperation:self.parseUrlsOperation];
    
    __weak typeof(self) weakSelf = self;
    self.parseUrlsOperation.completionBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.imagesUrls = strongSelf.operationDataContainer.imagesUrl;
            if (completion) {
                if ([strongSelf.imagesUrls count] > 0) {
                    completion(strongSelf.imagesUrls);
                }
            }
        }
    };
}

@end
