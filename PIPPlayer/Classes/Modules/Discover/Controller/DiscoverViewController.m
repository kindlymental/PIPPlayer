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

@interface DiscoverViewController ()

/** Banner */
// Banner
@property (nonatomic,strong) BannerView *bannerView;
// banner数组
@property (nonatomic,strong) NSMutableArray<BannerModel *> *bannerArray;

@end

@implementation DiscoverViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"发现";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bannerView];
    
    [self loadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
#if TARGET_VERSION_LITE
    NSLog(@"NO Debug");
#endif
    DiscoverVideoViewController *vc = [[DiscoverVideoViewController alloc]init];
    vc.aid = 37904664;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据请求

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
        _bannerView = [[BannerView alloc]initBannerViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.18) imageUrls:nil webUrls:nil timerInterval:4 noDataImage:@"misc_battery_power_ico" didSelect:^(NSUInteger Index) {
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



@end
