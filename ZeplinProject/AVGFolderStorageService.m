//
//  AVGFolderStorageService.m
//  ZeplinProject
//
//  Created by aiuar on 28.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFolderStorageService.h"

@implementation AVGFolderStorageService

#pragma mark - Saving image on disk

- (NSString *)saveImage:(UIImage *)image withID:(NSString *)identifier {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths.firstObject;
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *imageFolder = @"Images";
    NSString *imageName = [NSString stringWithFormat:@"%@.png", identifier];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",documentDirectory, imageFolder];
    
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:imagePath isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:NULL]){}
    
    [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/%@", imagePath, imageName] contents:nil attributes:nil];
    [imageData writeToFile:[NSString stringWithFormat:@"%@/%@", imagePath, imageName] atomically:YES];
    
    return [NSString stringWithFormat:@"%@/%@", imageFolder, imageName];
}

#pragma mark - Getting image from disk

- (UIImage *)getImageFrom:(NSString *)imagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths.firstObject;
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, imagePath]; // image path is same as above
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        return image;
    } else {
        return nil;
    }
}

@end
