//
//  ConfigModel.m
//  Music
//
//  Created by 刘怡兰 on 2018/12/1.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "ConfigModel.h"

@implementation ConfigModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
