//
//  VideoShowView.h
//  Music
//
//  Created by U on 2018/12/11.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SABlurImageView/SABlurImageView-Swift.h>
#import "VideoInfoModel.h"

@interface VideoShowView : UIView

@property (nonatomic,strong) VideoInfoModel *videoInfo;

@property (nonatomic,strong) void (^clickPlay)(void);

@end

