//
//  HomeHotTableViewCell.h
//  PIPPlayer
//
//  Created by 刘怡兰 on 2019/12/27.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHotTableViewCell : UITableViewCell

@property (nonatomic,strong) HomeHotModel *model;

@property (nonatomic,assign) BOOL hideBottomLine;

@end

NS_ASSUME_NONNULL_END
