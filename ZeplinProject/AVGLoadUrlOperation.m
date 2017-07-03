//
//  AVGLoadUrlOperation.m
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGLoadUrlOperation.h"
#import "AVGUrlContainer.h"

@interface AVGLoadUrlOperation ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@end

@implementation AVGLoadUrlOperation

#pragma mark - Load urls

- (void)main {
    if (self.sessionDataTask) {
        [self.sessionDataTask cancel];
    }
    
    if (self.session) {
        NSURLRequest *request = [self createRequest];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        self.sessionDataTask = [self.session dataTaskWithRequest:request
                                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                   
                                                   self.container.dataFromFlickr = data;
                                                   dispatch_semaphore_signal(semaphore);
                                               }];
        [self.sessionDataTask resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
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
    NSString *query = [self createQueryString];
    NSURL *url = [NSURL URLWithString:[query stringByAddingPercentEncodingWithAllowedCharacters:
                                       [NSCharacterSet URLFragmentAllowedCharacterSet]]];
    return url;
}

#pragma mark - Query

- (NSString *)createQueryString {
    NSURLComponents *components = [NSURLComponents componentsWithString:kApiBaseUrlString];
    NSDictionary *queryDictionary = @{ @"method":           kApiMethodPhotosSearch,
                                       @"license":          kApiLicense,
                                       @"has_geo":          kApiGeoData,
                                       @"extras":           kApiAdditionalInfo,
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
                                     stringWithFormat:@"&api_key=%s&text=%@&page=%ld&per_page=%ld", kApiKey, self.searchText, (long)self.page, (long)self.perPage];
    
    return [NSString stringWithFormat:@"%@%@", urlBaseString, urlParametersString];
}

@end
