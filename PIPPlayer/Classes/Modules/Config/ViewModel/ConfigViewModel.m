//
//  ConfigViewModel.m
//  Music
//
//  Created by 刘怡兰 on 2018/12/1.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "ConfigViewModel.h"
#import "BaseRequest.h"

#define URL_Config @"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1"

@implementation ConfigViewModel

+ (void)requestConfigWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    BaseRequest *request = [BaseRequest request];

    request.cacheTimeoutInterval = 60 * 30;
    request.willStoreCache = YES;
    
    [request requestWithURLString:URL_Config method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {

        if (request.responseObject) {
            
            NSLog(@"%@",request.responseObject);
        }
    }];
}

@end
