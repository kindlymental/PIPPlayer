//
//  HomeRecommendViewModel.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/2/6.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "HomeRecommendViewModel.h"
#import "BaseRequest.h"

@implementation HomeRecommendViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self requestData];
    }
    return self;
}

- (void)requestData {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            BaseRequest *request = [[BaseRequest alloc]init];
            [request
             requestWithURLString:@"https://app.bilibili.com/x/v2/feed/index?access_key=0b196c5b8d256b77c41ff76e6560f021&actionKey=appkey&appkey=27eb53fc9058f8c3&autoplay_card=2&banner_hash=7863274626291381714&build=9180&column=2&device=phone&device_name=iPhone%206S&flush=6&fnval=16&fnver=0&fourk=1&idx=1576758230&mobi_app=iphone&network=wifi&open_event=hot&platform=ios&pull=1&qn=32&recsys_mode=0&sign=d3fa34d7c7929df0ea4b465df44e31e5&statistics=%7B%22appId%22%3A1%2C%22version%22%3A%225.53.2%22%2C%22abtest%22%3A%22890%22%2C%22platform%22%3A1%7D&ts=1580964105" method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {
                
                if (request.responseCode == 0) {
            
                    NSArray *arr = [request.responseData objectForKey:@"items"];
                    
                    self.homeModelArray = [NSMutableArray array];
                    
                    for (NSDictionary *dic in arr) {
                        if ([dic objectForKey:@"title"]) {
                            HomeHotModel *model = [HomeHotModel yy_modelWithDictionary:dic];
                            [self.homeModelArray addObject:model];
                        }
                    }
                    
                    [subscriber sendNext:self.homeModelArray];
                }
            }];
            return nil;
        }];
        return signal;
    }];
}

@end
