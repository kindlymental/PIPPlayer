//
//  DiscoverViewController.m
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "DiscoverViewController.h"
#import "BannerView.h"
#import "BaseRequest.h"
#import "BannerModel.h"
#import "DiscoverVideoViewController.h"
#import "MoviePlayerView.h"
#import "DiscoverVideoTableViewCell.h"
#import "DiscoverVideoViewModel.h"
#import "FullViewController.h"

@interface DiscoverViewController () <UITableViewDelegate,UITableViewDataSource>

/** Banner */
// Banner
@property (nonatomic,strong) BannerView *bannerView;
// banner数组
@property (nonatomic,strong) NSMutableArray<BannerModel *> *bannerArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * videoSidArray; // videoSid数组

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
    
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom);
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
    return 260;
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

- (void)playButtonAction:(UIButton *)sender {
    Video * video = _videoViewModel.videoArray[sender.tag - 100];
    [self.videoPlayer setUrlString:video.mp4_url];
    self.videoPlayer.frame = CGRectMake(0, 240 + 260*(sender.tag - 100) + kScreenWidth/5 + 50  , kScreenWidth, (self.view.frame.size.width-20)/2);
    [self.view addSubview:self.videoPlayer];
    [_videoPlayer.player play];
    [_videoPlayer showToolView:NO];
    _videoPlayer.playOrPauseBtn.selected = YES;
    _videoPlayer.hidden = NO;
}

#pragma mark - 横向全屏
- (void)videoplayViewSwitchOrientation:(BOOL)isFull{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.videoPlayer];
            _videoPlayer.center = self.fullVc.view.center;
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _videoPlayer.frame = self.fullVc.view.bounds;
//                self.fmVideoPlayer.danmakuView.frame = self.fmVideoPlayer.frame;
                
            } completion:nil];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.view addSubview:self.videoPlayer];
            self.videoPlayer.frame = CGRectMake(0,  275 * _videoPlayer.index + kScreenWidth/5 + 50 , kScreenWidth, (kScreenWidth-20)/2);
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

- (void)loadData {
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    [request requestWithURLString:@"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1" method:HTTPMethodGet parameters:nil completionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            NSArray *arr = request.responseData;
            NSArray *bannerData = [[arr[0] objectForKey:@"banner"] objectForKey:@"top"];
            NSLog(@"%@",bannerData);
            
            for (NSDictionary *dic in bannerData) {
                BannerModel *model = [BannerModel yy_modelWithDictionary:dic];
                [self.bannerArray addObject:model];
            }
            
            NSMutableArray *urlArr = [NSMutableArray array];
            NSMutableArray *webArr = [NSMutableArray array];
            for (BannerModel *model in self.bannerArray) {
                [urlArr addObject:model.image];
                [webArr addObject:model.uri];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bannerView.urls = urlArr.copy;
                self.bannerView.webUrls = webArr.copy;
            });
        }
    }];
}

#pragma mark - 视图出现和消失的时候调用

- (void)startTimer {
    [self.bannerView startTimer];
}

- (void)pauseTimer{
    [self.bannerView pauseTimer];
}

#pragma mark - 懒加载

- (BannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[BannerView alloc]initBannerViewWithFrame:CGRectMake(0, 0, ScreenWidth, 240) imageUrls:nil webUrls:nil timerInterval:4 noDataImage:@"misc_battery_power_ico" didSelect:^(NSUInteger Index) {
            if ((Index - 1) >= 0 && (Index - 1) < self->_bannerView.webUrls.count) {
                NSLog(@"%@",self->_bannerView.webUrls[Index-1]);
            }
        }];
    }
    return _bannerView;
}

- (NSMutableArray<BannerModel *> *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

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
    }
    return _videoPlayer;
}

@end
