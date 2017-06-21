//
//  AVGParseInformationOperation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVGDetailedInformationContainer;

@interface AVGParseInformationOperation : NSOperation

@property (nonatomic, strong) AVGDetailedInformationContainer *container;

@end
