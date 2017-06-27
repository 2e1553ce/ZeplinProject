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
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Избранное" image:[UIImage imageNamed:@"icLikes"] tag:1];
        tabBarItem.titlePositionAdjustment = UIOffsetMake(-20, 0);
        self.tabBarItem = tabBarItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
}

@end
