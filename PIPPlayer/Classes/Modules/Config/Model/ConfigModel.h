//
//  ConfigModel.h
//  Music
//
//  Created by 刘怡兰 on 2018/12/1.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigModel : NSObject <NSCoding>

@property(nonatomic, copy) NSString *expiredtime;

@property(nonatomic, copy) NSString *version;

@property(nonatomic, copy) NSString *feedback;

@property(nonatomic, copy) NSString *updateurl;

@property(nonatomic, copy) NSString *exception;

@end
