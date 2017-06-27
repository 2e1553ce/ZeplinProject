//
//  AVGConstants.m
//  ZeplinProject
//
//  Created by aiuar on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGConstants.h"

const char *kApiKey = "c55f5a419863413f77af53764f86bd66";

NSString *const kApiBaseUrlString = @"https://api.flickr.com/services/rest/";

NSString *const kApiMethodPhotosSearch = @"flickr.photos.search";
NSString *const kApiMethodPhotoInfo = @"flickr.photos.getInfo";
NSString *const kApiMethodPhotoFavoritesInfo = @"flickr.photos.getFavorites";
NSString *const kApiMethodPhotoCommentsInfo = @"flickr.photos.comments.getList";

NSString *const kApiLicense = @"1,2,4,7";
NSString *const kApiGeoData = @"1";
NSString *const kApiAdditionalInfo = @"original_format,description,date_taken,geo,date_upload,owner_name,place_url,tags";

NSString *const kApiFormatJSON = @"json";
NSString *const kApiNoJSONCallback = @"1";
