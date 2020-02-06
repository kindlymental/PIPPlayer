//
//  BannerViewModel.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/2/6.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerViewModel : NSObject

//RAC
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic,strong) NSMutableArray<BannerModel *> *bannerModelArray;

@end

NS_ASSUME_NONNULL_END
