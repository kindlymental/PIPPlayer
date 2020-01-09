//
//  HomeSegmentView.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/9.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeSegmentViewDelegate <NSObject>

- (void)segmentChange:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HomeSegmentView : UIView

@property (nonatomic,weak) id<HomeSegmentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
