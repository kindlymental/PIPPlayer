//
//  BannerViewModel.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/2/6.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "BannerViewModel.h"
#import "BaseRequest.h"

@implementation BannerViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self requestBannerData];   // banner数据
    }
    return self;
}

- (void)requestBannerData {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            BaseRequest *request = [[BaseRequest alloc]init];
            [request
             requestWithURLString:@"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1" method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {
       
                if (request.responseCode == 0) {
                    NSArray *arr = request.responseData;
                    NSArray *bannerData = [[arr[0] objectForKey:@"body"] objectForKey:@"cover"];
                
                    for (NSDictionary *dic in bannerData) {
                        BannerModel *model = [BannerModel yy_modelWithDictionary:dic];
                        [self.bannerModelArray addObject:model];
                    }
                    
                    [subscriber sendNext:self.bannerModelArray];
                }
            }];
            return nil;
        }];
        return signal;
    }];
}

@end
