//
//  DiscoverViewController.m
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverVideoViewController.h"
#import "MoviePlayerView.h"
#import "DiscoverVideoTableViewCell.h"
#import "DiscoverVideoViewModel.h"
#import "FullViewController.h"
#import "BaseRequest.h"

@interface DiscoverViewController () <UITableViewDelegate,UITableViewDataSource,MoviePlayerViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) MoviePlayerView *videoPlayer; // 播放器

@property (nonatomic, strong) DiscoverVideoViewModel *videoViewModel;


/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;

@end

@implementation DiscoverViewController

static NSString *ID = @"cell";

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"发现";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self loadVideoArray];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoViewModel.videoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; 
    if (cell == nil) {
        cell = [[DiscoverVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.video = self.videoViewModel.videoArray[indexPath.row];
    [cell.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.playButton.tag = 100 + indexPath.row;
    return cell;
}

// 根据Cell位置隐藏并暂停播放
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.videoPlayer.index) {
        [_videoPlayer.player pause];
        _videoPlayer.hidden = YES;
    }
}

#pragma mark - 播放按钮点击事件
- (void)playButtonAction:(UIButton *)sender {
    _videoPlayer.index = sender.tag - 100;
    Video *video = _videoViewModel.videoArray[sender.tag - 100];
    [self.videoPlayer setUrlString:video.mp4_url];
    self.videoPlayer.frame = CGRectMake(0, 240 *(sender.tag - 100) + 40, kScreenWidth, 200);
    [self.tableView addSubview:self.videoPlayer];
    
    [_videoPlayer.player play];
    [_videoPlayer showToolView:NO];
    _videoPlayer.playOrPauseBtn.selected = YES;
    _videoPlayer.hidden = NO;
}

#pragma mark - 横向全屏
- (void)videoplayViewSwitchOrientation:(BOOL)isFull{
    if (isFull) {
        __weak typeof(self) weakself = self;
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [weakself.fullVc.view addSubview:weakself.videoPlayer];
            weakself.videoPlayer.center = weakself.fullVc.view.center;
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                weakself.videoPlayer.frame = weakself.fullVc.view.bounds;
//                self.fmVideoPlayer.danmakuView.frame = self.fmVideoPlayer.frame;
                
            } completion:nil];
        }];
    } else {
        __weak typeof(self) weakself = self;
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [weakself.tableView addSubview:weakself.videoPlayer];
            weakself.videoPlayer.frame = CGRectMake(0,  240 * weakself.videoPlayer.index + 40, kScreenWidth, 200);
        }];
    }

}

#pragma mark - 数据请求

- (void)loadVideoArray {
    
    RACSignal *signal = [self.videoViewModel.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - 懒加载

- (DiscoverVideoViewModel *)videoViewModel {
    if (!_videoViewModel) {
        _videoViewModel = [[DiscoverVideoViewModel alloc]init];
    }
    return _videoViewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DiscoverVideoTableViewCell class] forCellReuseIdentifier:ID];
    }
    return _tableView;
}

- (MoviePlayerView *)videoPlayer {
    if (!_videoPlayer) {
        _videoPlayer = [MoviePlayerView videoPlayView];
        _videoPlayer.delegate = self;
    }
    return _videoPlayer;
}

- (FullViewController *)fullVc {
    if (!_fullVc) {
        _fullVc = [[FullViewController alloc]init];
    }
    return _fullVc;
}

@end
