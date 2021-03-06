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

- (UITabBarController *)initialMainUI {
    
    UITabBarController *tabBarVc = [[UITabBarController alloc]init];
    
    HomePageViewController *homeVc = [[HomePageViewController alloc]init];
    homeVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[self getOriginalImage:@"tab_home_24x24_"] selectedImage:[self getOriginalImage:@"tab_home_pre_24x24_"]];
    NavigationViewController *nav_home = [[NavigationViewController alloc]initWithRootViewController:homeVc];
    
    DiscoverViewController *discoverVc = [[DiscoverViewController alloc]init];
    discoverVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[self getOriginalImage:@"tab_custom_24x24_"] selectedImage:[self getOriginalImage:@"tab_custom_pre_24x24_"]];
    NavigationViewController *nav_discover = [[NavigationViewController alloc]initWithRootViewController:discoverVc];
    
    MineViewController *mineVc = [[MineViewController alloc]init];
    mineVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[self getOriginalImage:@"tab_mine_24x24_"] selectedImage:[self getOriginalImage:@"tab_mine_pre_24x24_"]];
    NavigationViewController *nav_mine = [[NavigationViewController alloc]initWithRootViewController:mineVc];
    
    tabBarVc.viewControllers = @[nav_home, nav_discover, nav_mine];
    
    // 设置tabBarItem样式
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
       [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor systemPinkColor]} forState:UIControlStateSelected];
       
    return tabBarVc;
}

- (UIImage *)getOriginalImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return newImage;
}

@end
