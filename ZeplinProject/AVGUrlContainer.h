//
//  AVGUrlContainer.h
//  FlickerImages
//
//  Created by aiuar on 28.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGImageInformation;

@interface AVGUrlContainer : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSData *dataFromFlickr;
@property (nonatomic, copy) NSArray <AVGImageInformation *> *imagesUrl;

@end
