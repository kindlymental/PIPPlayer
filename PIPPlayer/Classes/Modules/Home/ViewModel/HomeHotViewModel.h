//
//  HomeHotViewModel.h
//  Music
//
//  Created by 刘怡兰 on 2019/12/26.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeHotModel.h"
#import "HomeOuterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHotViewModel : NSObject

//RAC
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

//@property (nonatomic,strong) NSMutableArray<HomeHotModel *> *hotModelArray;

@property (nonatomic,strong) NSMutableArray<HomeOuterModel *> *homeModelArray;

@end

NS_ASSUME_NONNULL_END
