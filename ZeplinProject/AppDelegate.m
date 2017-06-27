//
//  AppDelegate.m
//  ZeplinProject
//
//  Created by iOS-School-1 on 27.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AppDelegate.h"
#import "AVGFeedViewController.h"
#import "AVGFavoriteViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UITabBarController *tabBarController = [UITabBarController new];
    
    AVGFeedViewController *wallVC = [AVGFeedViewController new];
    AVGFavoriteViewController *favoriteVC = [AVGFavoriteViewController new];
    
    UINavigationController *navWallVC = [[UINavigationController alloc] initWithRootViewController:wallVC];
    UINavigationController *navFavoriteVC = [[UINavigationController alloc] initWithRootViewController:favoriteVC];

    tabBarController.viewControllers = @[navWallVC, navFavoriteVC];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

/*
razmer kartinki ot kolichestva likov/stars/favorites
  > 200 likov
collectionView s castom layout, svoi layouti
*/
