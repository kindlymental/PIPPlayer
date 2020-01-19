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
#import "HomeCollectionViewCell.h"
#import "VideoPlayerViewController.h"
#import "HomeHeaderView.h"
#import "HomeSegmentView.h"

static NSString *collectionCellID = @"collectionCellID";
static NSString *homeTableViewCellID = @"homeTableViewCellID";

@interface HomePageViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,HomeSegmentViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) HomeSegmentView *segmentView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 导航
    self.segmentView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.segmentView.intrinsicContentSize = CGSizeMake(ScreenWidth, 44);
    self.navigationItem.titleView = self.segmentView;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.collectionView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.equalTo(self.scrollView);
        make.width.mas_offset(ScreenWidth);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.scrollView);
        make.left.equalTo(self.tableView.mas_right);
        make.width.mas_offset(ScreenWidth);
    }];
}

#pragma mark - HomeSegmentViewDelegate

- (void)segmentChange:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homeHotViewModel.homeModelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeHotViewModel.homeModelArray[section].body.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10); // 分别为上、左、下、右
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    if (indexPath.row < self.homeHotViewModel.homeModelArray[indexPath.section].body.count) {
        cell.model = self.homeHotViewModel.homeModelArray[indexPath.section].body[indexPath.row];
    }
    return cell;
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
    HomeHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellID];
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
            [self.collectionView reloadData];
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

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.scrollEnabled = YES;
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _scrollView.backgroundColor = ColorRGB(233, 233, 233);
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeHotTableViewCell" bundle:nil] forCellReuseIdentifier:homeTableViewCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
   
        // 设置item的大小
        CGFloat itemW = (kScreenWidth - 30) / 2;
        layout.itemSize = CGSizeMake(itemW, itemW);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (HomeSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[HomeSegmentView alloc]initWithFrame:CGRectZero];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

@end
