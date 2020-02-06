//
//  HomeRecommendViewModel.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/2/6.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRecommendViewModel : NSObject

//RAC
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic,strong) NSMutableArray<HomeHotModel *> *homeModelArray;

@end

NS_ASSUME_NONNULL_END
