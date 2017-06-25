//
//  AVGLoadInformationOperation.m
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGLoadInformationOperation.h"
#import "AVGDetailedInformationContainer.h"

@interface AVGLoadInformationOperation ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@end

@implementation AVGLoadInformationOperation

#pragma mark - Initialization

- (instancetype)initWithMethod:(AVGURLMethodType)method {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
        self.method = method;
    }
    return  self;
}

#pragma mark - Load image information

- (void)main {
    
    if (self.sessionDataTask) {
        [self.sessionDataTask cancel];
    }
    
    NSString *urlMethod;
    switch (self.method) {
        case AVGURLMethodTypeInfo:
            urlMethod = @"flickr.photos.getInfo";
            break;
        case AVGURLMethodTypeFavorites:
            urlMethod = @"flickr.photos.getFavorites";
            break;
        case AVGURLMethodTypeComments:
            urlMethod = @"flickr.photos.comments.getList";
            break;
    }
    
    NSString *query = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=%@&api_key=c55f5a419863413f77af53764f86bd66&nojsoncallback=1&format=json&photo_id=%@", urlMethod, self.container.imageID];
    NSURL *url = [NSURL URLWithString:[query stringByAddingPercentEncodingWithAllowedCharacters:
                                       [NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    self.sessionDataTask = [self.session dataTaskWithRequest:request
                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                               
                                               switch (self.method) {
                                                   case AVGURLMethodTypeInfo:
                                                       self.container.imageInformation = data;
                                                       break;
                                                   case AVGURLMethodTypeFavorites:
                                                       self.container.likesInformation = data;
                                                       break;
                                                   case AVGURLMethodTypeComments:
                                                       self.container.commentsInformation = data;
                                                       break;
                                               }
                                               dispatch_semaphore_signal(semaphore);
                                           }];
    [self.sessionDataTask resume];
#warning needed?
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self.session finishTasksAndInvalidate];
}

@end
