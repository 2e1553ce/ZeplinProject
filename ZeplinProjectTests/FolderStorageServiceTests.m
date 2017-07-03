//
//  FolderStorageServiceTests.m
//  ZeplinProject
//
//  Created by aiuar on 03.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AVGFolderStorageService.h"

@interface FolderStorageServiceTests : XCTestCase

@property (nonatomic, strong) AVGFolderStorageService *service;

@end

@implementation FolderStorageServiceTests

- (void)setUp {
    [super setUp];
    
    self.service = [AVGFolderStorageService new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSavedLoadedImageForEqual {
    UIImage *imageToSave = [UIImage imageNamed:@"test"];
    NSString *path = [self.service saveImage:imageToSave withID:@"testID"];
    UIImage *loadedImage = [self.service getImageFrom:path];
    
    NSData *imageOne = UIImagePNGRepresentation(imageToSave);
    NSData *imageTwo = UIImagePNGRepresentation(loadedImage);
    
    XCTAssertEqualObjects(imageOne, imageTwo, @"Saved image and loaded image are different!");
}

- (void)testImageForNil {
    UIImage *imageToSave = [UIImage imageNamed:@"test"];
    NSString *path = [self.service saveImage:imageToSave withID:@"testID"];
    UIImage *loadedImage = [self.service getImageFrom:path];
    XCTAssertNotNil(loadedImage, @"Image loaded from disk is nil!");
}

- (void)testFolderPathForNil {
    UIImage *imageToSave = [UIImage imageNamed:@"test"];
    NSString *path = [self.service saveImage:imageToSave withID:@"testID"];
    XCTAssertNotNil(path, @"Folder path is nil!");
}

- (void)testFolderPath {
    UIImage *imageToSave = [UIImage imageNamed:@"test"];
    NSString *pathOne = [self.service saveImage:imageToSave withID:@"testID"];
    
    NSString *imageFolder = @"Images";
    NSString *imageName = @"testID.png";
    NSString *pathTwo = [NSString stringWithFormat:@"%@/%@", imageFolder, imageName];
    XCTAssertEqualObjects(pathOne, pathTwo, @"Image folder path is broken!");
}

@end
