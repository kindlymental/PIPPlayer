//
//  HomeHotTableViewCell.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2019/12/27.
//  Copyright © 2019 com.lyl.demo. All rights reserved.
//

#import "HomeHotTableViewCell.h"
#import "EdgeInsetsLabel.h"

@interface HomeHotTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation HomeHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 6;
    
    self.typeLabel.layer.borderColor = ColorRGB(220, 124, 100).CGColor;
    self.typeLabel.layer.borderWidth = 1;
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.cornerRadius = 4;
    self.typeLabel.edgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    
    if (_hideBottomLine == YES) {
        self.bottomLine.hidden = YES;
    } else {
        self.bottomLine.hidden = NO;
    }
}

- (void)setModel:(HomeHotModel *)model {
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"misc_battery_power_ico"]];
    self.titleLabel.text = model.title;
    self.typeLabel.text = [NSString stringWithFormat:@"%ld个喜欢",model.like];
    self.nameLabel.text = model.name;
    self.timesLabel.text = [NSString stringWithFormat:@"%ld观看",model.play];
}

@end
