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

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@end

@implementation AVGLoadInformationOperation

#pragma mark - Initialization

- (instancetype)initWithMethod:(AVGURLMethodType)method {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig];
        _method = method;
    }
    return  self;
}

#pragma mark - Load image information

- (void)main {
    if (self.sessionDataTask) {
        [self.sessionDataTask cancel];
    }
    
    NSURLRequest *request = [self createRequest];
    
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
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

#pragma mark - Request

- (NSURLRequest *)createRequest {
    NSURL *url = [self createURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return request;
}

#pragma mark - URL

- (NSURL *)createURL {
    NSString *urlMethod;
    switch (self.method) {
        case AVGURLMethodTypeInfo:
            urlMethod = kApiMethodPhotoInfo;
            break;
        case AVGURLMethodTypeFavorites:
            urlMethod = kApiMethodPhotoFavoritesInfo;
            break;
        case AVGURLMethodTypeComments:
            urlMethod = kApiMethodPhotoCommentsInfo;
            break;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithString:kApiBaseUrlString];
    NSDictionary *queryDictionary = @{ @"method":           urlMethod,
                                       @"format":           kApiFormatJSON,
                                       @"nojsoncallback":   kApiNoJSONCallback
                                       };
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSString *urlBaseString = [components.URL absoluteString];
    
    NSString *urlParametersString = [NSString
                                     stringWithFormat:@"&api_key=%s&photo_id=%@", kApiKey, self.container.imageID];
    
    NSString *query = [NSString stringWithFormat:@"%@%@", urlBaseString, urlParametersString];
    NSURL *url = [NSURL URLWithString:[query stringByAddingPercentEncodingWithAllowedCharacters:
                                       [NSCharacterSet URLFragmentAllowedCharacterSet]]];
    return url;
}

@end
