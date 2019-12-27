//
//  HomeHotModel.h
//  Music
//
//  Created by 刘怡兰 on 2019/12/26.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHotModel : NSObject

@property (nonatomic, assign) NSInteger cm_mark;
@property (nonatomic, assign) NSInteger danmaku;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) NSInteger play;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *rname;

@end

NS_ASSUME_NONNULL_END
