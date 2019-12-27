//
//  ConfigViewModel.h
//  Music
//
//  Created by 刘怡兰 on 2018/12/1.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigModel.h"

@interface ConfigViewModel : NSObject

+ (void)requestConfigWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
