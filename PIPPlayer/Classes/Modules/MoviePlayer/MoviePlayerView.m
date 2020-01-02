//
//  MoviePlayerView.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/2.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "MoviePlayerView.h"

@interface MoviePlayerView ()

// imageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 工具栏
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) AVPlayerLayer *playerLayer;

// 记录当前是否显示了工具栏
@property (assign, nonatomic) BOOL isShowToolView;

/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;

/* 工具栏的显示和隐藏 */
@property (nonatomic, strong) NSTimer *showTimer;

/* 工具栏展示的时间 */
@property (assign, nonatomic) NSTimeInterval showTime;

@property (nonatomic, strong) NSTimer * timer;


@end

@implementation MoviePlayerView

// 快速创建View的方法
+ (instancetype)videoPlayView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MoviePlayerView" owner:nil options:nil] firstObject];
    
 }

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.player = [[AVPlayer alloc]init];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imageView.layer addSublayer:self.playerLayer];
    
    // 设置工具栏的状态
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    // 设置按钮的状态
    self.playOrPauseBtn.selected = NO;
    
    // 设置进度条的内容
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
    [self showToolView:YES];
    
//    [self setupDanmakuView];
//    [self setupDanmakuData];
    
}

// 点击背景 是否显示工具的View
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self showToolView:!self.isShowToolView];
}

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}


- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.currentItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    [self.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
}

- (void)moviePlayDidEnd:(NSNotification *)notification {
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.progressSlider setValue:0.0 animated:YES];
        weakSelf.playOrPauseBtn.selected = NO;
    }];
}

#pragma mark - 观察者对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (AVPlayerItemStatusReadyToPlay == status) {
            [self removeProgressTimer];
            [self addProgressTimer];
            // WARNING
//            [_danmakuView start];
        } else {
            [self removeProgressTimer];
        }
    }
}

#pragma mark - 定时器操作
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (NSString *)timeString
{
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    return [self stringWithCurrentTime:currentTime duration:duration];
}

- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    
    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
}

- (void)updateProgressInfo
{
    // 1.更新时间
    self.timeLabel.text = [self timeString];
    
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
    if(self.progressSlider.value == 1)
    {
        self.progressSlider.value = 0;
        self.progressSlider.tag = 100;
        self.player = nil;
        self.playOrPauseBtn.selected = NO;
        self.toolView.alpha = 1;
        
        [self removeProgressTimer];
        [self removeShowTimer];
        self.timeLabel.text = @"00:00/00:00";
        return;

    }
}

- (void)addShowTimer
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateShowTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.showTimer forMode:NSRunLoopCommonModes];
}

- (void)removeShowTimer
{
    [self.showTimer invalidate];
    self.showTimer = nil;
}

- (void)updateShowTime
{
    self.showTime += 1;
    
    if (self.showTime > 2.0) {
//        [self tapAction:nil];
        [self removeShowTimer];
        
        self.showTime = 0;
    }
}

- (void)showToolView:(BOOL)isShow
{
    if (self.progressSlider.tag == 100) {
        
        self.progressSlider.tag = 20;
        return;
    
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.toolView.alpha = !self.isShowToolView;
        self.isShowToolView = !self.isShowToolView;
    }];
}


#pragma mark - 事件

- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender == nil) {
        self.playOrPauseBtn.selected = NO;
    }
    if (sender.selected) {
        [self.player play];
        [self addShowTimer];
        [self addProgressTimer];
//        if (_danmakuView.isPrepared) {
//            if (!_timer) {
//                _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
//            }
//            [_danmakuView start];
//        }
    } else {
        [self.player pause];
        [self removeShowTimer];
        [self removeProgressTimer];
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
//        [_danmakuView pause];
    }
}

#pragma mark - progress slider 事件处理

- (IBAction)sliderTouchDown:(id)sender {
    [self removeProgressTimer];
}

- (IBAction)sliderTouchUpInside:(id)sender {
    [self addProgressTimer];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)sliderValueChange:(id)sender {
    [self removeProgressTimer];
    [self removeShowTimer];
    if (self.progressSlider.value == 1) {
        self.progressSlider.value = 0;
    }
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    self.timeLabel.text = [self stringWithCurrentTime:currentTime duration:duration];
    [self addShowTimer];
    [self addProgressTimer];
}

#pragma mark - 转向按钮事件

- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_delegate videoplayViewSwitchOrientation:sender.selected];
}


@end
