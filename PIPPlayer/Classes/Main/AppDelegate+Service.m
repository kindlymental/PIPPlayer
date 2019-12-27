//
//  AppDelegate+Service.m
//  Music
//
//  Created by U on 2018/11/29.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "AppDelegate+Service.h"
/** 导航 */
#import "NavigationViewController.h"
/** 首页 */
#import "HomePageViewController.h"
/** 发现 */
#import "DiscoverViewController.h"
/** 我的 */
#import "MineViewController.h"
/** 菜单页 */
#import "MenuViewController.h"

@implementation AppDelegate (Service)

/**
 初始化主框架UI

 @return 侧边栏
 */
//- (RESideMenu *)initialMainUI {
//
//    HomePageViewController * HomeVc = [[HomePageViewController alloc]init];
//    NavigationViewController * nav = [[NavigationViewController alloc]initWithRootViewController:HomeVc];
//
//    MenuViewController * leftVC = [[MenuViewController alloc]init];
//
//    RESideMenu * reslide = [[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:nil];
//
//    reslide.fadeMenuView = NO;
//    reslide.scaleMenuView = NO;
//    reslide.scaleContentView = NO;
//    reslide.contentViewInLandscapeOffsetCenterX = ScreenWidth *0.25;
//    reslide.contentViewInPortraitOffsetCenterX  = ScreenWidth *0.25;
//    reslide.contentViewShadowEnabled = NO;
//    reslide.bouncesHorizontally = NO;
//    reslide.animationDuration = 0.25f;
//    reslide.parallaxEnabled = NO;
//
//    return reslide;
//}

- (UITabBarController *)initialMainUI {
    
    UITabBarController *tabBarVc = [[UITabBarController alloc]init];
    
    HomePageViewController *homeVc = [[HomePageViewController alloc]init];
    homeVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[self getOriginalImage:@"tab_home_24x24_"] selectedImage:[self getOriginalImage:@"tab_home_pre_24x24_"]];
    NavigationViewController *nav_home = [[NavigationViewController alloc]initWithRootViewController:homeVc];
    
    DiscoverViewController *discoverVc = [[DiscoverViewController alloc]init];
    discoverVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[self getOriginalImage:@"tab_custom_24x24_"] selectedImage:[self getOriginalImage:@"tab_custom_pre_24x24_"]];
    NavigationViewController *nav_discover = [[NavigationViewController alloc]initWithRootViewController:discoverVc];
    
    HomePageViewController *mineVc = [[HomePageViewController alloc]init];
    mineVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[self getOriginalImage:@"tab_mine_24x24_"] selectedImage:[self getOriginalImage:@"tab_mine_pre_24x24_"]];
    NavigationViewController *nav_mine = [[NavigationViewController alloc]initWithRootViewController:mineVc];
    
    tabBarVc.viewControllers = @[nav_home, nav_discover, nav_mine];
    
    return tabBarVc;
}

- (UIImage *)getOriginalImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return newImage;
}

@end
