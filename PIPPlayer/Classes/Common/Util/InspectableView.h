//
//  InspectableView.h
//  WasherV3
//
//  Created by U on 2018/9/7.
//  Copyright © 2018年 厦门悠生活网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectableView : UIView

@property (nonatomic, assign) IBInspectable CGFloat connerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@end
