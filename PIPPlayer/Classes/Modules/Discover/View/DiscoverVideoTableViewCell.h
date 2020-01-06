//
//  DiscoverVideoTableViewCell.h
//  Music
//
//  Created by U on 2018/12/10.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePlayerView.h"
@class Video;

@interface DiscoverVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) MoviePlayerView * playerView;
@property (nonatomic, strong) UILabel          * timeLabel;
@property (nonatomic, strong) UILabel          * titleLabel;
@property (nonatomic, strong) UIButton          * playButton;
@property (nonatomic, strong) UIImageView      * backImage;

@property (nonatomic, strong) Video            * video;

@end
