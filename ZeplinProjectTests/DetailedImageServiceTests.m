//
//  DetailedImageServiceTests.m
//  ZeplinProject
//
//  Created by aiuar on 01.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AVGDetailedImageService.h"
#import "AVGDetailedImageInformation.h"

@interface DetailedImageServiceTests : XCTestCase

@property (nonatomic, strong) AVGDetailedImageService *service;

@end

@implementation DetailedImageServiceTests

- (void)setUp {
    [super setUp];
    NSString *const imageID = @"35447048031";
    self.service = [[AVGDetailedImageService alloc] initWithImageID:imageID];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testForNil {
    XCTAssertNotNil(self.service, @"Detailed image service is nil!");
}

- (void)testDownloadedInformation {
    [self.service getImageInformationWithCompletionHandler:^(AVGDetailedImageInformation *info) {
        XCTAssertNotNil(info, @"No image information!");
        XCTAssertNotNil(info.title, @"Image title is nil!");
        XCTAssertNotNil(info.imageDescription, @"Image description is nil!");
        XCTAssertNotNil(info.location, @"Image location is nil!");
        XCTAssertNotNil(info.ownerNickName, @"Image owner nickname is nil!");
        XCTAssertNotNil(info.ownerAvatarUrl, @"Image owner avatar url is nil!");
        
        XCTAssertGreaterThanOrEqual((int)[info.commentators count], 0, @"Commentators count cant be < 0");
        XCTAssertGreaterThanOrEqual((int)[info.likesInfo count], 0, @"Likes information count cant be < 0");
    }];
}

- (void)testNoThrow {
    XCTAssertNoThrow([self.service getImageInformationWithCompletionHandler:^(AVGDetailedImageInformation *info) {}], @"Exception when used getImageInformation");
}

@end
