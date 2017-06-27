//
//  AVGCoreDataStack.h
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

@class CoreData;

@interface AVGCoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *privateContext;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Core data stack initialization

 @return Self
 */
- (instancetype)initStack NS_DESIGNATED_INITIALIZER;
+ (instancetype)stack;

@end
