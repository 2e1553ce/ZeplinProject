//
//  AVGImage.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class AVGOwner;

@interface AVGImage : NSManagedObject

@property (nullable, nonatomic, copy) NSString *folderPath;
@property (nullable, nonatomic, copy) NSString *identifier;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *ownerID;
@property (nullable, nonatomic, retain) AVGOwner *owner;

@end
