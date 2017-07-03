//
//  AVGBinaryImageOperation.h
//  FlickerImages
//
//  Created by aiuar on 24.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGLoadBinarizeContainer;

@interface AVGBinaryImageOperation : NSBlockOperation

@property (nonatomic, strong) AVGLoadBinarizeContainer *operationDataContainer;

@end
