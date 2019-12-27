//
//  UIViewController+LifeCircle.m
//  Music
//
//  Created by U on 2018/12/10.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "UIViewController+LifeCircle.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (LifeCircle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"dealloc") with:@selector(aop_dealloc)];
        [self swizzleInstanceMethod:NSSelectorFromString(@"viewWillDisappear:") with:@selector(aop_viewWillDisappear:)];
        [self swizzleInstanceMethod:NSSelectorFromString(@"viewWillAppear:") with:@selector(aop_viewWillAppear:)];
    });
}

- (void)aop_dealloc {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"UI"]) {
        NSLog(@"dealloc: %@",className);
    }
    [self aop_dealloc];
}

- (void)aop_viewWillAppear:(BOOL)animated  {
    
    NSString *className = NSStringFromClass([self class]);
    
    // DiscoverViewController
    if ([className isEqualToString:@"DiscoverViewController"]) {
//        Class disCoverVc = objc_getClass("DiscoverViewController");
        //发送startTimer消息给disCoverVc
        SEL startTimer = NSSelectorFromString(@"startTimer");
        ((void (*)(id, SEL))(void *) objc_msgSend)((id)self, startTimer);
    }
    
    [self aop_viewWillAppear:animated];
}

- (void)aop_viewWillDisappear:(BOOL)animated  {
    
    NSString *className = NSStringFromClass([self class]);
    
    // DiscoverViewController
    if ([className isEqualToString:@"DiscoverViewController"]) {
        //发送pauseTimer消息给disCoverVc
        SEL pauseTimer = NSSelectorFromString(@"pauseTimer");
        ((void (*)(id, SEL))(void *) objc_msgSend)((id)self, pauseTimer);
    }
    
    [self aop_viewWillDisappear:animated];
}

@end
