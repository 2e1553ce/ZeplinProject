//
//  AVGUrlService.h
//  FlickerImages
//
//  Created by aiuar on 26.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGUrlProtocol.h"

@class AVGImageInformation;

@interface AVGUrlService : NSObject <AVGUrlProtocol>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSArray <AVGImageInformation *> *imagesUrls;

@end
