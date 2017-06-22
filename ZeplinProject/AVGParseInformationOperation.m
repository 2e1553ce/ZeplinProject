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

- (void)main {
    AVGDetailedImageInformation *imageInfo = [AVGDetailedImageInformation new];
    
    if (self.container.imageInformation) {
        // title, description, nickOwnera, location, avatarURL
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.imageInformation
                                                             options:0
                                                               error:&error];
        dict = dict[@"photo"];
        
        NSDictionary *titleDict = dict[@"title"];
        NSString *title = titleDict[@"_content"];
        
        NSDictionary *descriptionDict = dict[@"title"];
        NSString *description = descriptionDict[@"_content"];
        
        NSDictionary *ownerDict = dict[@"owner"];
        NSString *nickName = ownerDict[@"username"];
        
        NSDictionary *locationDict = dict[@"location"];
        NSDictionary *localityDict = locationDict[@"locality"];
        NSString *locality = localityDict[@"_content"];
        NSDictionary *regionDict = locationDict[@"region"];
        NSString *region = regionDict[@"_content"];
        NSString *location = [NSString stringWithFormat:@"%@, %@", locality, region];
        if (!location || [location isEqualToString: @""]) {
            location = ownerDict[@"location"];
        }

        NSString *iconfarm = ownerDict[@"iconfarm"];
        NSString *iconserver = ownerDict[@"iconserver"];
        NSString *nsid = ownerDict[@"nsid"];
        NSString *ownerAvatarURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconfarm, iconserver, nsid];
        
        imageInfo.title = title;
        imageInfo.imageDescription = description;
        imageInfo.ownerNickName = nickName;
        imageInfo.location = location;
        imageInfo.ownerAvatarUrl = ownerAvatarURL;
    }
    
    if (self.container.likesInformation) {
        // likes count, nickName, avatarUrl, date
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.likesInformation
                                                             options:0
                                                               error:&error];
        dict = dict[@"photo"];
        dict = dict[@"person"];
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
        
        imageInfo.likeCount = likesCount;
        imageInfo.likesInfo = likesInformation;
    }
    
    if (self.container.commentsInformation) {
        // For each AVGCOmmentator - avatarURL, nickName, comment, date
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.commentsInformation
                                                             options:0
                                                               error:&error];
        dict = dict[@"comments"];
        dict = dict[@"comment"];
        NSMutableArray *commentsInformation = [NSMutableArray new];
        for (id person in dict) {
            AVGCommentator *commentator = [AVGCommentator new];
            commentator.nickName = person[@"authorname"];
            #warning remove tags
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
        
        imageInfo.commentators = commentsInformation;
    }
    self.container.information = imageInfo;
}

@end
