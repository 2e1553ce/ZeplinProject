//
//  AVGDetailedImageService.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGDetailedInformationProtocol.h"

@class AVGDetailedImageInformation;

@interface AVGDetailedImageService : NSObject <AVGDetailedInformationProtocol>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithImageID:(NSString *)imageID NS_DESIGNATED_INITIALIZER;

@end
