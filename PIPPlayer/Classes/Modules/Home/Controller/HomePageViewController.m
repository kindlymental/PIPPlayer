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
#import "HomeHotViewModel.h"
#import "HomeHotTableViewCell.h"
#import "VideoPlayerViewController.h"
#import "HomeHeaderView.h"

@interface HomePageViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *tableView;

/** 接受全部数据的数组 */
@property (nonatomic,strong) HomeHotViewModel *homeHotViewModel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    
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
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homeHotViewModel.homeModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeHotViewModel.homeModelArray[section].body.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeHeaderView *headerView = [[HomeHeaderView alloc]initWithFrame:CGRectZero];
    headerView.outerModel = self.homeHotViewModel.homeModelArray[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HomeCell";
    HomeHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeHotTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row < self.homeHotViewModel.homeModelArray[indexPath.section].body.count) {
        cell.model = self.homeHotViewModel.homeModelArray[indexPath.section].body[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoPlayerViewController *vc = [[VideoPlayerViewController alloc]init];
    vc.aid = 37904664;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据请求

- (void)loadData {
    
    RACSignal *signal = [self.homeHotViewModel.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - 懒加载

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
