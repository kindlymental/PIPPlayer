//
//  DiscoverVideoTableViewCell.m
//  Music
//
//  Created by U on 2018/12/10.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "DiscoverVideoTableViewCell.h"
#import "Video.h"

@implementation DiscoverVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(10);
            make.top.equalTo(self).mas_offset(4);
        }];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).mas_offset(10);
            make.top.equalTo(self).mas_offset(4);
        }];
    }
    return _timeLabel;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        [_playButton setTitleColor:ColorRGB(31, 31, 31) forState:UIControlStateNormal];
        _playButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.mas_offset(44);
        }];
    }
    return _playButton;
}

- (void)setVideo:(Video *)video
{
    self.titleLabel.text = video.title;
    self.timeLabel.text = [video.ptime substringWithRange:NSMakeRange(12, 4)];
    
    [self.playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
}

@end
