//
//  MoviePlayerView.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/2.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  MoviePlayerViewDelegate <NSObject>

- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface MoviePlayerView : UIView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic,strong) AVPlayerItem *currentItem;
@property (nonatomic,strong, nullable) AVPlayer *player;
@property (nonatomic, copy) NSString *urlString;

// 背景图
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

// 初始化方法
+ (instancetype)videoPlayView;

- (void)showToolView:(BOOL)isShow;

/* 代理 */
@property (nonatomic, assign) id<MoviePlayerViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
