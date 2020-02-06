//
//  BannerView.m
//
//  Created by U on 2018/12/7.
//

#import "BannerView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BannerItem : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation BannerItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end


@interface BannerView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    UICollectionView *_collectionView;
    NSTimer *_scrollTimer;
    UIPageControl *_pageControl;
    // 无数据的默认图片名称
    NSString *_noDataImageName;
}

// 滚动间隔时长
@property (assign, nonatomic) NSTimeInterval scrollTimeInterval;
// 当前选中的索引
@property (assign, nonatomic) NSInteger index;

@property (nonatomic, copy) DidSelectBannerItemBlock didSelectBannerItemBlock;

@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame noDataImageName:(NSString *)imageName {
    
    if (self = [super initWithFrame:frame]) {
      
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _noDataImageName = imageName;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BannerItem class] forCellWithReuseIdentifier:@"Banner"];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = CGreen;
        
        [self addSubview:_collectionView];
        [self addSubview:_pageControl];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset = -5;
            make.right.offset = -15;
            make.height.offset = 14;
            make.width.offset = 0;
        }];
    }
    return self;
}

- (instancetype)initBannerViewWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls webUrls:(NSArray *)webUrls timerInterval:(NSTimeInterval)timerInterval noDataImage:(NSString *)imageName didSelect:(DidSelectBannerItemBlock)didSelect {
    
    BannerView *bannerView = [[BannerView alloc]initWithFrame:frame noDataImageName:imageName];
    
    bannerView.scrollTimeInterval = timerInterval;
    bannerView.urls = imageUrls;
    bannerView.didSelectBannerItemBlock = didSelect;
    bannerView.webUrls = webUrls;
      
    return bannerView;
}

#pragma mark - 定时器

- (void)startTimer {
    
    if (_scrollTimer) {
        [self pauseTimer];
    }
    if (_scrollTimeInterval > 0 && self.urls.count > 0) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_scrollTimeInterval target:self selector:@selector(scroll) userInfo:NULL repeats:YES];
    }
}

- (void)pauseTimer {
    [_scrollTimer invalidate];
    _scrollTimer = NULL;
}

- (void)scroll {
    NSInteger scrollIndex = _index + 1;
    if (_index == _urls.count - 1) {
        scrollIndex = 0;
    }
    [_collectionView setContentOffset:CGPointMake(_collectionView.width * scrollIndex, 0) animated:YES];
    
    NSLog(@"Banner定时器");
}

#pragma mark - getter / setter

- (void)setUrls:(NSArray<NSURL *> *)urls {
    
    BOOL nullData = false;
    
    if (![urls isKindOfClass:[NSArray class]] || urls.count == 0) {
        
        nullData = true;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *bannerCache = [defaults objectForKey:@"bannerCache"];
        if (bannerCache) {
            urls = bannerCache;
            if ([urls isKindOfClass:[NSArray class]] && urls.count > 0) {
                nullData = false;
            }
        }
    }
    
    // 无数据提示
    if (nullData) {
        [_collectionView reloadData];
        return;
    }
    
    // 剪裁
    NSMutableArray *imageURLs = [[NSMutableArray alloc]init];
    for (NSURL *url in urls) {
        NSString *imgUrlStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_%f,w_%f/quality,q_75",url, self.height * 0.5, self.width * 0.5];
        [imageURLs addObject:[NSURL URLWithString:imgUrlStr]];
    }
    
    if ([urls count] <= 1) {
        _urls = [imageURLs copy];
        _collectionView.bounces = NO;
        [self pauseTimer];
        [_collectionView reloadData];
        [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 0;
        }];
    } else {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:imageURLs.count];
        [array addObject:imageURLs.lastObject];
        [array addObjectsFromArray:imageURLs];
        [array addObject:imageURLs.firstObject];
        
        _urls = [array copy];
        _collectionView.bounces = YES;
        [_collectionView reloadData];
        
        [_collectionView setContentOffset:CGPointMake(_collectionView.width, 0)];
        self.index = 1;
        
        // 启动定时器
        [self startTimer];
        
        _pageControl.numberOfPages = urls.count;
        [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset = [self->_pageControl sizeForNumberOfPages:urls.count].width;
        }];
    }
    
    // 缓存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:urls forKey:@"bannerCache"];
    [defaults synchronize];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (_index == 0 || _index == _urls.count-1) {
        return;
    }
    _pageControl.currentPage = _index - 1;
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate / UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_urls count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BannerItem *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell.imageView sd_setImageWithURL:_urls[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.urls.count == 0) {
        return;
    }    
    if (self.didSelectBannerItemBlock) {
        self.didSelectBannerItemBlock(indexPath.item % self.urls.count);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.index = scrollView.contentOffset.x / scrollView.width;
    if (_index == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * (_urls.count - 2), 0) animated:NO];
        self.index = _urls.count - 2;
    }
    else if (_index == _urls.count-1) {
        [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
        self.index = 1;
    }
    
    [self startTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    self.index = scrollView.contentOffset.x / scrollView.width;
    if (_index == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * (_urls.count - 2), 0) animated:NO];
        self.index = _urls.count - 2;
    }
    else if (_index == _urls.count-1) {
        [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
        self.index = 1;
    }
}

#pragma mark - DZNEmptyDataSetSource / DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:_noDataImageName];
}


#pragma mark - 捕获父控制器的视图显示和消失方法,相应的打开和暂停定时器

+ (void)load {
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    swizzleInstanceMethod:NSSelectorFromString(@"viewWillDisappear:") with:@selector(aop_viewWillDisappear)];
//        [self swizzleInstanceMethod:NSSelectorFromString(@"viewWillAppear:") with:@selector(aop_viewWillAppear)];
//    });
}

- (void)aop_viewWillDisappear {
    [self pauseTimer];
    
}

- (void)aop_viewWillAppear {
    [self startTimer];
}

- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end


