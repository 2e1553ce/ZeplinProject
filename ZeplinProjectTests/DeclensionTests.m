//
//  DeclensionTests.m
//  ZeplinProject
//
//  Created by aiuar on 01.07.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Declension.h"

@interface DeclensionTests : XCTestCase

@end

@implementation DeclensionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDeclensionString {
    AVGDeclensionType type = AVGDeclensionTypeComment;
    
    NSString *declensionString = @"комментариев";
    NSInteger count = 11;
    NSString *result = [NSString declensionStringFor:type andCount:count];
    XCTAssertEqualObjects(declensionString, result, @"Declension failed at 11!");
    count = 12;
    XCTAssertEqualObjects(declensionString, result, @"Declension failed at 12!");
    
    declensionString = @"комментарий";
    count = 1;
    result = [NSString declensionStringFor:type andCount:count];
    XCTAssertEqualObjects(declensionString, result, @"Declension failed at 1!");
    
    declensionString = @"комментария";
    count = 3;
    result = [NSString declensionStringFor:type andCount:count];
    XCTAssertEqualObjects(declensionString, result, @"Declension failed at 3!");
}

@end
