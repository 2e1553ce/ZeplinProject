//
//  AVGDetailedInformationContainer.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVGDetailedImageInformation;

@interface AVGDetailedInformationContainer : NSObject

@property (nonatomic, copy) NSString *imageID;

@property (nonatomic, strong) NSData *imageInformation;
@property (nonatomic, strong) NSData *likesInformation;
@property (nonatomic, strong) NSData *commentsInformation;

@property (nonatomic, strong) AVGDetailedImageInformation *information;

@end
