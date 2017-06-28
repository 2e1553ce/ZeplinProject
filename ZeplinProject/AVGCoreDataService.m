//
//  AVGCoreDataService.m
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGCoreDataService.h"
#import "AVGCoreDataStack.h"
#import "AVGDetailedImageInformation.h"
#import "AVGImage.h"
#import "AVGOwner.h"

@interface AVGCoreDataService ()

@property (nonatomic, strong) AVGCoreDataStack *stack;

@end

#pragma mark - Initialization

@implementation AVGCoreDataService

- (instancetype)init {
    self = [super init];
    if (self) {
        _stack = [AVGCoreDataStack stack];
    }
    return self;
}

#pragma mark - Save image info and path

- (void)saveImageInformation:(AVGDetailedImageInformation *)imageInfo andFolderPath:(NSString *)folderPath {
    NSMutableDictionary *ownerAttributes = [NSMutableDictionary new];
    ownerAttributes[@"id"] = imageInfo.ownerIdentifier;
    ownerAttributes[@"nickName"] = imageInfo.ownerNickName;
    
    NSMutableDictionary *imageAttributes = [NSMutableDictionary new];
    imageAttributes[@"folderPath"] = folderPath;
    imageAttributes[@"identifier"] = imageInfo.identifier;
    imageAttributes[@"location"] = imageInfo.location;
    imageAttributes[@"title"] = imageInfo.title;
    imageAttributes[@"ownerID"] = imageInfo.ownerIdentifier;
    
    [self insertNewObjectForEntityForName:@"AVGOwner" withDictionary:ownerAttributes];
    [self insertNewObjectForEntityForName:@"AVGImage" withDictionary:imageAttributes];
    NSLog(@"");
}

#pragma mark - Get image info

- (NSArray *)getImagesInformation {
    NSArray<AVGImage*> *images = [self fetchEntities:@"AVGImage" withPredicate:nil];
    NSMutableArray<AVGDetailedImageInformation*> *imagesInfo = [NSMutableArray new];
    
    for (AVGImage *image in images) {
        NSString *identifier = image.ownerID;
        AVGOwner *owner = [self fetchEntity:@"AVGOwner" forKey:identifier];
        
        AVGDetailedImageInformation *imageInfo = [AVGDetailedImageInformation new];
        imageInfo.identifier = image.identifier;
        imageInfo.title = image.title;
        imageInfo.location = image.location;
        imageInfo.ownerNickName = owner.nickName;
        imageInfo.folderPath = image.folderPath;
        [imagesInfo addObject:imageInfo];
    }
    
    return [imagesInfo copy];
}

#pragma mark - Core Data methods

- (void)save {
    [self.stack.privateContext performBlockAndWait:^{
        if (self.stack.privateContext.hasChanges) {
            NSError *error = nil;
            [self.stack.privateContext save:&error];
            if (error) {}
        }
    }];
    [self.stack.mainContext performBlock:^{
        if (self.stack.mainContext.hasChanges) {
            NSError *error = nil;
            [self.stack.mainContext save:&error];
            if (error) {}
        }
    }];
}

- (void)insertNewObjectForEntityForName:(NSString *)name withDictionary:(NSDictionary<NSString *, id> *)attributes {
    [self.stack.privateContext performBlock:^{
        id entity = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.stack.privateContext];
        for (NSString *attribute in attributes) {
            [entity setValue:attributes[attribute] forKey:attribute];
        }
        [self save];
    }];
}

- (id)fetchEntity:(NSString *)entity forKey:(NSString *)key {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"id == %@", key];
    NSError *error = nil;
    NSArray *results = [self.stack.mainContext executeFetchRequest:request error:&error];
    if (results.count == 0) {
        return nil;
    } else if (results.count > 1) {}
    return results[0];
}

- (NSArray *)fetchEntities:(NSString *)entity withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entity];
    request.fetchBatchSize = 30;
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *fetchedArray = [self.stack.mainContext executeFetchRequest:request error:&error];
    if (error) {}
    return fetchedArray;
}

@end
