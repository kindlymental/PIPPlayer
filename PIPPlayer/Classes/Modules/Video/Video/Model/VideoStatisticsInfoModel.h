//
//  VideoStatisticsInfoModel.h
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 视频统计
 */
@interface VideoStatisticsInfoModel : NSObject

/**
 *  播放
 */
@property (assign, nonatomic) NSInteger view;

/**
 *  弹幕
 */
@property (assign, nonatomic) NSInteger danmaku;

/**
 *  评论
 */
@property (assign, nonatomic) NSInteger reply;

/**
 *  喜欢
 */
@property (assign, nonatomic) NSInteger favorite;

/**
 *  硬币
 */
@property (assign, nonatomic) NSInteger coin;

/**
 *  分享
 */
@property (assign, nonatomic) NSInteger share;

@end
