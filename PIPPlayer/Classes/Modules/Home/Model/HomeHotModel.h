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
@property (nonatomic, copy) NSString *param;
@property (nonatomic, copy) NSString *gotoType;
@property (nonatomic, assign) BOOL *is_ad;

/** 推荐信息 */
@property (nonatomic, copy) NSString *cover_left_text_1;
@property (nonatomic, copy) NSString *cover_left_icon_1;
@property (nonatomic, copy) NSString *cover_right_text;
@property (nonatomic, strong) NSDictionary *desc_button;
@property (nonatomic, strong) NSDictionary *args;

@end

NS_ASSUME_NONNULL_END
