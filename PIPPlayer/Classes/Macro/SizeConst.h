//
//  SizeConst.h
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#ifndef SizeConst_h
#define SizeConst_h

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

// 判断是否是iPhoneX 或 iPhoneXS 或 iPhoneXR 或 iPhoneXS Max
static inline BOOL isIPhoneXSeries() {
    
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
#define IS_IPHONE_SafeAreaBottomNotZero    isIPhoneXSeries()  // 是否是iPhoneX系列

// 状态栏高度
#define UI_STATUS_BAR_HEIGHT      (IS_IPHONE_SafeAreaBottomNotZero ? 44 : 20)
// 导航栏高度
#define UI_NAVIGATION_BAR_HEIGHT         44
// 导航栏和状态栏总高度
#define UI_NAVIGATION_BAR_and_StatusBar_HEIGHT (UI_STATUS_BAR_HEIGHT+UI_NAVIGATION_BAR_HEIGHT)
// 底部TabBar高度
#define UI_TABBAR_HEIGHT     (IS_IPHONE_SafeAreaBottomNotZero ? 40+34 : 34)


#define Font(fontSize) [UIFont fontWithName:@"ArialMT" size:fontSize]

#endif /* SizeConst_h */
