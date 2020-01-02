//
//  DiscoverVideoViewModel.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/2.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "DiscoverVideoViewModel.h"
#import "BaseRequest.h"

#define videoArrayURL @"http://c.m.163.com/nc/video/home/0-10.html"

@implementation DiscoverVideoViewModel

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
             requestWithURLString:videoArrayURL method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {
                if (request.responseCode == 0) {
            
                    NSArray *arr = request.responseObject[@"videoList"];
                    for (NSDictionary *dic in arr) {
                        Video *video = [Video yy_modelWithDictionary:dic];
                        [self.videoArray addObject:video];
                    }
                    
                    [subscriber sendNext:self.videoArray];
                } 
            }];
            return nil;
        }];
        return signal;
    }];
}

- (NSMutableArray<Video *> *)videoArray {
    if (!_videoArray) {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}

@end
