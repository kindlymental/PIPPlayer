//
//  InspectableLabel.m
//  Music
//
//  Created by U on 2018/12/3.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "InspectableLabel.h"

IB_DESIGNABLE

@implementation InspectableLabel

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
