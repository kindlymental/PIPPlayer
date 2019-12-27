//
//  InspectableLabel.h
//  Music
//
//  Created by U on 2018/12/3.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspectableLabel : UILabel

@property (nonatomic, assign) IBInspectable CGFloat connerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@end

