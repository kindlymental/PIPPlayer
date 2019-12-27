//
//  VideoShowView.m
//  Music
//
//  Created by U on 2018/12/11.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "VideoShowView.h"

@interface VideoShowView ()

@property (strong, nonatomic) SABlurImageView *backgroundView;

@end

@implementation VideoShowView {
    
    UIButton *_playButton;  // 播放按钮
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - UI

- (void)loadUI {
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    _playButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_playButton];
    
    [self insertSubview:self.backgroundView belowSubview:_playButton];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).mas_offset(15);
    }];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - 赋值

- (void)setVideoInfo:(VideoInfoModel *)videoInfo {
    
    _videoInfo = videoInfo;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [self insertSubview:self.backgroundView belowSubview:_playButton];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.backgroundView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic] placeholderImage:NULL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakSelf.backgroundView configrationForBlurAnimation:100];
    }];
}

#pragma mark - 事件

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    _clickPlay ? _clickPlay() : NULL;
}

#pragma mark - 懒加载

- (SABlurImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[SABlurImageView alloc]init];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundView;
}

@end
