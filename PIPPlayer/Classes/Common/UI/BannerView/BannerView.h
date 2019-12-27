//
//  BannerView.h
//
//  Created by U on 2018/12/7.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectBannerItemBlock)(NSUInteger Index);

@interface BannerView : UIView

// url集合
@property (copy, nonatomic) NSArray<NSURL *> *urls;
// 点击跳转的web集合
@property (copy, nonatomic) NSArray<NSURL *> *webUrls;

- (instancetype)initBannerViewWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls webUrls:(NSArray *)webUrls timerInterval:(NSTimeInterval)timerInterval noDataImage:(NSString *)imageName didSelect:(DidSelectBannerItemBlock)didSelect;

- (void)startTimer;

- (void)pauseTimer;

@end
