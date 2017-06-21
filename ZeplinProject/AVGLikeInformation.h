//
//  AVGLikeInformation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVGLikeInformation : NSObject

@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSDate *date;

@end