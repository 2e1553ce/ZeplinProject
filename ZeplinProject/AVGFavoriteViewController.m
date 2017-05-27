//
//  AVGFavoriteViewController.m
//  ZeplinProject
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGFavoriteViewController.h"

@interface AVGFavoriteViewController ()

@end

@implementation AVGFavoriteViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UITabBarItem *tabBar = [[UITabBarItem alloc] initWithTitle:@"Избранное" image:[UIImage imageNamed:@"icLikes"] tag:1];
        self.tabBarItem = tabBar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
}

@end
