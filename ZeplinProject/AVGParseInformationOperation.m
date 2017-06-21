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
        NSString *location = [NSString stringWithFormat:@"%@, %@", region, locality];
        if (!location || [location isEqualToString: @""]) {
            location = ownerDict[@"location"];
        }

        NSString *iconfarm = ownerDict[@"iconfarm"];
        NSString *iconserver = ownerDict[@"iconserver"];
        NSString *nsid = ownerDict[@"nsid"];
        NSString *ownerAvatarURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconfarm, iconserver, nsid];
        //http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
    }
    
    if (self.container.likesInformation) {
        // likes count, nickName, avatarUrl, date
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.likesInformation
                                                             options:0
                                                               error:&error];
        dict = dict[@"photos"];
    }
    
    if (self.container.commentsInformation) {
        // Dlya kazhdogo AVGCOmmentator - avatarURL, nickName, comment, date
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.container.commentsInformation
                                                             options:0
                                                               error:&error];
        dict = dict[@"photos"];
    }
}

@end
