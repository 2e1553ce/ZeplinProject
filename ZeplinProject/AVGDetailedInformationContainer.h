//
//  AVGDetailedInformationContainer.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//
@class AVGDetailedImageInformation;

@interface AVGDetailedInformationContainer : NSObject

@property (nonatomic, copy) NSString *imageID;

@property (nonatomic, copy) NSData *imageInformation;
@property (nonatomic, copy) NSData *likesInformation;
@property (nonatomic, copy) NSData *commentsInformation;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) AVGDetailedImageInformation *information;

@end
