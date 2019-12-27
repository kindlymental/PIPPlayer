//
//  HomePageViewController.m
//  Music
//
//  Created by U on 2018/11/29.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "BaseRequest.h"
#import "BannerModel.h"
#import "DiscoverVideoViewController.h"
#import "HomeHotViewModel.h"

@interface HomePageViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *tableView;

/** Banner */
// Banner
@property (nonatomic,strong) BannerView *bannerView;
// banner数组
@property (nonatomic,strong) NSMutableArray<BannerModel *> *bannerArray;

/** 接受全部数据的数组 */
@property (nonatomic,strong) HomeHotViewModel *homeHotViewModel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSubviews];
    
    [self loadData];
}

#pragma mark - 界面布局

- (void)loadSubviews {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(UI_NAVIGATION_BAR_and_StatusBar_HEIGHT);
    }];
    
//    [self.view addSubview:self.bannerView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeHotViewModel.hotModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.homeHotViewModel.hotModelArray[indexPath.row].name;
    [cell.imageView sd_setImageWithURL: [NSURL URLWithString:self.homeHotViewModel.hotModelArray[indexPath.row].cover]];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

#pragma mark - 数据请求

- (void)loadData {
    
    RACSignal *signal = [self.homeHotViewModel.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
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
        _bannerView = [[BannerView alloc]initBannerViewWithFrame:CGRectMake(0, UI_NAVIGATION_BAR_and_StatusBar_HEIGHT, ScreenWidth, ScreenHeight * 0.20) imageUrls:nil webUrls:nil timerInterval:4 noDataImage:@"misc_battery_power_ico" didSelect:^(NSUInteger Index) {
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

- (HomeHotViewModel *)homeHotViewModel {
    if (!_homeHotViewModel) {
        _homeHotViewModel = [[HomeHotViewModel alloc]init];
    }
    return _homeHotViewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
