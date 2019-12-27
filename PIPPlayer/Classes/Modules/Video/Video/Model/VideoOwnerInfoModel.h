//
//  VideoOwnerInfoModel.h
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Up主信息
 */
@interface VideoOwnerInfoModel : NSObject

@property (assign, nonatomic) NSInteger mid;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *face;

@end

