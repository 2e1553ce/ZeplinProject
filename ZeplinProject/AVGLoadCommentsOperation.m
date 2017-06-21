//
//  AVGLoadCommentsOperation.m
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGLoadCommentsOperation.h"
#import "AVGDetailedInformationContainer.h"

@interface AVGLoadCommentsOperation ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@end

@implementation AVGLoadCommentsOperation

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return  self;
}

#pragma mark - Load image information

- (void)main {
    
    if (self.sessionDataTask) {
        [self.sessionDataTask cancel];
    }
    
    NSString *urlBaseString = @"https://api.flickr.com/services/rest/?method=flickr.photos.comments.getList&api_key=c55f5a419863413f77af53764f86bd66&nojsoncallback=1&format=json&";
    NSString *urlParametersString = [NSString stringWithFormat:@"photo_id=%@", self.container.imageID];
    NSString *query = [NSString stringWithFormat:@"%@%@", urlBaseString, urlParametersString];
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
                                               
                                               self.container.commentsInformation = data;
                                               dispatch_semaphore_signal(semaphore);
                                           }];
    [self.sessionDataTask resume];
#warning needed?
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self.session finishTasksAndInvalidate];
}


@end
