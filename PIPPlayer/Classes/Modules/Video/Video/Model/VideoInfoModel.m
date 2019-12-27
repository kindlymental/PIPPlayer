//
//  VideoInfoModel.m
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "VideoInfoModel.h"

@implementation VideoInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"pages": NSStringFromClass([VideoPageInfoModel class]), @"relates": NSStringFromClass([VideoInfoModel class])};
}

@end
