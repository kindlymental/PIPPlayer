//
//  VideoPlayerViewController.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2019/12/27.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "VideoShowView.h"
#import "VideoInfoModel.h"
#import "VideoInfoViewModel.h"

#import "MediaPlayer.h"

@interface VideoPlayerViewController ()

/** 视图 */
@property (nonatomic,strong) VideoShowView *showView;

/** 数据 */
@property (nonatomic,strong) VideoInfoViewModel *videoModel;

@end

@implementation VideoPlayerViewController {
    
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
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
        make.height.mas_offset(ScreenHeight * 0.22);
    }];
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

#pragma mark - 播放视频

- (void)playVideo {
    
    if (!self.videoModel.videoInfo) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.videoModel requestVideoURLWithVideoCid:_currentPage.cid success:^(NSURL *videoURL) {
        
        if (videoURL) {
            // 测试地址
            [MediaPlayer playerWithURL:[NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"] cid:self->_currentPage.cid title:self->_currentPage.part inViewController:weakSelf];
//            http://vjs.zencdn.net/v/oceans.mp4
//            http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4
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
        _showView.clickBack = ^{
            // 返回上一页
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _showView;
}

@end
