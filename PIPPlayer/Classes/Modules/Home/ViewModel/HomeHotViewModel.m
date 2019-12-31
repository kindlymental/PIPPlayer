//
//  HomeHotViewModel.m
//  Music
//
//  Created by 刘怡兰 on 2019/12/26.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import "HomeHotViewModel.h"
#import "BaseRequest.h"

@interface HomeHotViewModel()

@end

@implementation HomeHotViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            BaseRequest *request = [[BaseRequest alloc]init];
            [request
             requestWithURLString:@"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1" method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {
                if (request.responseCode == 0) {
            
                    NSArray *arr = request.responseData;
                    
                    self.homeModelArray = [NSMutableArray array];
                    
                    for (NSDictionary *dic in arr) {
                        HomeOuterModel *model = [HomeOuterModel yy_modelWithDictionary:dic];
                        [self.homeModelArray addObject:model];
                    }
                    
                    [subscriber sendNext:self.homeModelArray];
                } else {
                    
                }
            }];
            return nil;
        }];
        return signal;
    }];
}

@end
