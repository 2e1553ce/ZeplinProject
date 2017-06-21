//
//  AVGDetailedImageInformation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVGCommentator;
@class UIImageView;

@interface AVGDetailedImageInformation : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageDescription;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) NSString *ownerNickName;
@property (nonatomic, strong) NSString *ownerAvatarUrl;

@property (nonatomic, strong) NSArray<AVGCommentator*> *commentators;

@end
