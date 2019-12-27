//
//  VideoInfoModel.h
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPageInfoModel.h"
#import "VideoOwnerInfoModel.h"
#import "VideoStatisticsInfoModel.h"

@interface VideoInfoModel : NSObject

@property (assign, nonatomic) NSInteger aid;

@property (assign, nonatomic) NSInteger tid;

@property (strong, nonatomic) NSString *tname;

@property (strong, nonatomic) NSString *pic;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger pubdate;

@property (strong, nonatomic) NSString *desc;

/**
 *  Up主信息
 */
@property (strong, nonatomic) VideoOwnerInfoModel *owner;

/**
 *  统计信息
 */
@property (strong, nonatomic) VideoStatisticsInfoModel *stat;


@property (strong, nonatomic) NSArray<NSString *> *tags;

/**
 *  分集
 */
@property (strong, nonatomic) NSArray<VideoPageInfoModel *> *pages;

/**
 *  视频相关
 */
@property (strong, nonatomic) NSArray<VideoInfoModel *> *relates;

@end


