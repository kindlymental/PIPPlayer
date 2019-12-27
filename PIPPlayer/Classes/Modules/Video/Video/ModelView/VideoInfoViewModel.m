//
//  VideoViewModel.m
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "VideoInfoViewModel.h"

#import "BaseRequest.h"
#import "VideoURLViewModel.h"

#define URL_Config @"http://app.bilibili.com/x/view?actionKey=appkey&aid=##aid##&appkey=27eb53fc9058f8c3&build=3380"

@implementation VideoInfoViewModel

- (void)requestVideoInfoWithVideoAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    BaseRequest *request = [BaseRequest request];
    
    request.cacheTimeoutInterval = 60 * 30;
    request.willStoreCache = YES;
    
    __weak __typeof(self)weakSelf = self;
    
    [request requestWithURLString:URL_Config method:HTTPMethodGet parameters:@{
                                                                               @"aid": @(aid)
                                                                               } completionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0 && request.responseData) {
            
            weakSelf.videoInfo = [VideoInfoModel yy_modelWithJSON:request.responseData];
            if ([weakSelf.videoInfo.pages count] == 1) {
                weakSelf.videoInfo.pages[0].part = weakSelf.videoInfo.title;
            }
            
            success();
            
            /**
             新增历史记录
             */
//            HistoryEntity *history = [[HistoryEntity alloc] initWithVideoInfo:_videoInfo];
//            [HistoryModel addHistory:history];
        } else {
            failure(request.errorMsg);
        }
    }];
}

- (void)requestVideoURLWithVideoCid:(NSInteger)cid success:(void (^)(NSURL *videoURL))success failure:(void (^)(NSString *errorMsg))failure {
    
    __block NSInteger page;
    [_videoInfo.pages enumerateObjectsUsingBlock:^(VideoPageInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.cid == cid) {
            page = obj.page;
        }
    }];
    
    [VideoURLViewModel requestVideoURLWithAid:_videoInfo.aid cid:cid page:page completionBlock:success];
}

@end
