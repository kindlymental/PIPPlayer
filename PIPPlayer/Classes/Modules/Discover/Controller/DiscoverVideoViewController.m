//
//  DiscoverVideoViewController.m
//  Music
//
//  Created by U on 2018/12/10.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "DiscoverVideoViewController.h"
#import "VideoShowView.h"
#import "VideoInfoModel.h"
#import "VideoInfoViewModel.h"

#import "MediaPlayer.h"

@interface DiscoverVideoViewController () <UIGestureRecognizerDelegate>

/** 视图 */
@property (nonatomic,strong) VideoShowView *showView;

/** 数据 */
@property (nonatomic,strong) VideoInfoViewModel *videoModel;

@end

@implementation DiscoverVideoViewController {
    
    VideoPageInfoModel *_currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 视图和数据

- (void)loadUI {
    
    [self.view addSubview:self.showView];
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(ScreenHeight * 0.18);
    }];
    
    // 手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    NSArray *internalTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer *headerPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
    headerPanGesture.delegate = self;
    [self.showView addGestureRecognizer:headerPanGesture];
}

- (void)loadData {
    
    if (!_aid) {
        return;
    }
    
    self.videoModel = [[VideoInfoViewModel alloc]init];
    self.videoModel.aid = self.aid;
    
    __weak __typeof(self)weakSelf = self;
    [self.videoModel requestVideoInfoWithVideoAid:self.aid success:^(void) {
        
        if (weakSelf.videoModel.videoInfo.pages.count) {
            self->_currentPage = self.videoModel.videoInfo.pages[0];
        }
        
        [weakSelf.showView setVideoInfo:weakSelf.videoModel.videoInfo];
        
    } failure:^(NSString *errorMsg) {
        
    }];
}

#pragma mark - UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
//
//    CGPoint translation = [gestureRecognizer translationInView:_backgroundScrollView];
//    if (gestureRecognizer.view == self.showView) {
//        return translation.x > 0;
//    }
//    else if (gestureRecognizer.view == _backgroundScrollView) {
//        return _backgroundScrollView.contentOffset.x == 0 && translation.x > 0;
//    }
//    else {
//        return NO;
//    }
//}

#pragma mark - 播放视频

- (void)playVideo {
    
    if (!self.videoModel.videoInfo) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.videoModel requestVideoURLWithVideoCid:_currentPage.cid success:^(NSURL *videoURL) {
        
        if (videoURL) {
            [MediaPlayer playerWithURL:videoURL cid:self->_currentPage.cid title:self->_currentPage.part inViewController:weakSelf];
        }
    } failure:^(NSString *errorMsg) {
        
    }];
}

#pragma mark - 懒加载

- (VideoShowView *)showView {
    if (!_showView) {
        _showView = [[VideoShowView alloc]init];
        
        __weak __typeof(self)weakSelf = self;
        _showView.clickPlay = ^{
            // 播放视频
            [weakSelf playVideo];
        };
    }
    return _showView;
}

@end
