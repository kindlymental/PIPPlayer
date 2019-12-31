//
//  HomeOuterModel.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2019/12/31.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeOuterModel : NSObject

@property (nonatomic,copy) NSString *param;
@property (nonatomic,strong) NSMutableArray<HomeHotModel *> *body;
@property (nonatomic,copy) NSString *style;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
