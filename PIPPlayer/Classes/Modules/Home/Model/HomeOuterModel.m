//
//  HomeOuterModel.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2019/12/31.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import "HomeOuterModel.h"

@implementation HomeOuterModel

- (void)setBody:(NSMutableArray<HomeHotModel *> *)body {
    _body = body;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (body && body.count != 0) {
        for (NSDictionary *dic in body) {
            HomeHotModel *model = [HomeHotModel yy_modelWithDictionary:dic];
            [arr addObject:model];
        }
        _body = arr;
    }
}

@end
