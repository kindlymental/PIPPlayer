//
//  AppDelegate.h
//  Music
//
//  Created by U on 2018/11/29.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (nonatomic,strong) RESideMenu *reslide;
@property (nonatomic,strong) UITabBarController *tabBarVc;

+ (AppDelegate *)sharedInstance;

@end

