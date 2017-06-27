//
//  AVGOwner.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGImage;

@interface AVGOwner : NSManagedObject

@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSString *avatarFolderPath;
@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSSet<AVGImage *> *image;

@end

@interface AVGOwner (CoreDataGeneratedAccessors)

- (void)addImageObject:(AVGImage *_Nullable)value;
- (void)removeImageObject:(AVGImage *_Nullable)value;
- (void)addImage:(NSSet<AVGImage *> *_Nullable)values;
- (void)removeImage:(NSSet<AVGImage *> *_Nullable)values;

@end
