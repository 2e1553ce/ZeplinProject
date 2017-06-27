//
//  AVGParseInformationOperation.m
//  ZeplinProject
//
//  Created by aiuar on 21.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGParseInformationOperation.h"
#import "AVGDetailedImageInformation.h"
#import "AVGDetailedInformationContainer.h"

@implementation AVGParseInformationOperation

#pragma mark - Parsing

- (void)main {
    AVGDetailedImageInformation *imageInfo = [AVGDetailedImageInformation new];
    
    if (self.container.imageInformation) {
        [self parseImageInfo:imageInfo];
    }
    
    if (self.container.likesInformation) {
        [self parseLikesInfo:(AVGDetailedImageInformation *)imageInfo];
    }
    
    if (self.container.commentsInformation) {
        [self parseCommentsInfo:imageInfo];
    }
    self.container.information = imageInfo;
}

#pragma mark - Parsing image info

- (void)parseImageInfo:(AVGDetailedImageInformation *)imageInfo {
    // title, description, ownerNickName, location, avatarURL
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.imageInformation
                                                         options:0
                                                           error:&error];
    dict = dict[@"photo"];
    
    // Image title
    NSDictionary *titleDict = dict[@"title"];
    NSString *title = titleDict[@"_content"];
    
    // Image description
    NSDictionary *descriptionDict = dict[@"title"];
    NSString *description = descriptionDict[@"_content"];
    
    // Owner nickname
    NSDictionary *ownerDict = dict[@"owner"];
    NSString *nickName = ownerDict[@"username"];
    
    // Image location
    NSDictionary *locationDict = dict[@"location"];
    NSDictionary *localityDict = locationDict[@"locality"];
    
    NSString *locality = localityDict[@"_content"];
    NSDictionary *regionDict = locationDict[@"region"];
    
    NSString *region = regionDict[@"_content"];
    NSString *location;
    if (locality) {
        location = [NSString stringWithFormat:@"%@", locality];
        if (region) {
            location = [NSString stringWithFormat:@"%@, %@", location, region];
        }
    } else {
        location = [NSString stringWithFormat:@"%@", region];
        if (!location || [location isEqualToString: @""]) {
            location = ownerDict[@"location"];
        }
    }
    
    // Owner avatarURL
    NSString *iconfarm = ownerDict[@"iconfarm"];
    NSString *iconserver = ownerDict[@"iconserver"];
    NSString *nsid = ownerDict[@"nsid"];
    NSString *ownerAvatarURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconfarm, iconserver, nsid];
    
    // Adding to model
    imageInfo.title = title;
    imageInfo.imageDescription = description;
    imageInfo.ownerNickName = nickName;
    imageInfo.location = location;
    imageInfo.ownerAvatarUrl = ownerAvatarURL;
}

#pragma mark - Parsing likes info

- (void)parseLikesInfo:(AVGDetailedImageInformation *)imageInfo {
    // likes count, nickName, avatarUrl, date
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.likesInformation
                                                         options:0
                                                           error:&error];
    dict = dict[@"photo"];
    dict = dict[@"person"];
    
    // Getting likes information
    NSInteger likesCount = [dict count];
    NSMutableArray *likesInformation = [NSMutableArray new];
    for (id person in dict) {
        AVGLikeInformation *likeInfo = [AVGLikeInformation new];
        likeInfo.nickName = person[@"username"];
        likeInfo.date = person[@"favedate"];
        
        NSString *iconfarm = person[@"iconfarm"];
        NSString *iconserver = person[@"iconserver"];
        NSString *nsid = person[@"nsid"];
        NSString *avatarURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconfarm, iconserver, nsid];
        likeInfo.avatarURL = avatarURL;
        
        [likesInformation addObject:likeInfo];
    }
    // Adding to model
    imageInfo.likeCount = likesCount;
    imageInfo.likesInfo = likesInformation;
}

#pragma mark - Parsing comments info

- (void)parseCommentsInfo:(AVGDetailedImageInformation *)imageInfo {
    // For each AVGCOmmentator - avatarURL, nickName, comment, date
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.commentsInformation
                                                         options:0
                                                           error:&error];
    dict = dict[@"comments"];
    dict = dict[@"comment"];
    
    // Getting comments
    NSMutableArray *commentsInformation = [NSMutableArray new];
    for (id person in dict) {
        AVGCommentator *commentator = [AVGCommentator new];
        commentator.nickName = person[@"authorname"];
#warning check for nil
        commentator.comment = person[@"_content"];
        commentator.date = person[@"datecreate"];
        
        NSString *iconfarm = person[@"iconfarm"];
        NSString *iconserver = person[@"iconserver"];
        NSString *nsid = person[@"author"];
        NSString *avatarURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconfarm, iconserver, nsid];
        commentator.avatarURL = avatarURL;
        
        [commentsInformation addObject:commentator];
    }
    // Adding to model
    imageInfo.commentators = commentsInformation;
}

@end
