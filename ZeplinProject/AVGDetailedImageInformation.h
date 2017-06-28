//
//  AVGDetailedImageInformation.h
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGCommentator.h"
#import "AVGLikeInformation.h"

@interface AVGDetailedImageInformation : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageDescription;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *folderPath;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *ownerIdentifier;
@property (nonatomic, copy) NSString *ownerNickName;
@property (nonatomic, copy) NSString *ownerAvatarUrl;

@property (nonatomic, copy) NSArray<AVGCommentator*> *commentators;
@property (nonatomic, copy) NSArray<AVGLikeInformation*> *likesInfo;

@end
