//
//  VideoInfoViewModel.h
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoInfoModel.h"

@interface VideoInfoViewModel : NSObject

@property (nonatomic,strong) VideoInfoModel *videoInfo;

@property (assign, nonatomic) NSInteger aid;

/**
 请求视频数据

 @param aid keyId
 @param success 成功
 @param failure 失败
 */
- (void)requestVideoInfoWithVideoAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


/**
 请求视频地址

 @param aid keyId
 @param success 成功
 @param failure 失败
 */
- (void)requestVideoURLWithVideoCid:(NSInteger)cid success:(void (^)(NSURL *videoURL))success failure:(void (^)(NSString *errorMsg))failure;

@end


