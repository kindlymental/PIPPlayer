//
//  UIButton+EnlargeTouchArea.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/20.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)setEnlargeEdge:(CGFloat) size;

@end

NS_ASSUME_NONNULL_END
