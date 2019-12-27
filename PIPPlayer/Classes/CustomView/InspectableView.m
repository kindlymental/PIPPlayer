//
//  InspectableView.m
//  WasherV3
//
//  Created by U on 2018/9/7.
//  Copyright © 2018年 厦门悠生活网络科技. All rights reserved.
//

#import "InspectableView.h"

IB_DESIGNABLE

@implementation InspectableView

- (void)setConnerRadius:(CGFloat)connerRadius {
    _connerRadius = connerRadius;
    self.layer.cornerRadius = _connerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}
    
@end
