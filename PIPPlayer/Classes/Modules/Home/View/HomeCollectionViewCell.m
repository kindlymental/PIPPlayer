//
//  HomeCollectionViewCell.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/9.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "EdgeInsetsLabel.h"

@interface HomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;

@end

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6;
    
    self.typeLabel.layer.borderColor = ColorRGB(220, 124, 100).CGColor;
    self.typeLabel.layer.borderWidth = 1;
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.cornerRadius = 4;
    self.typeLabel.edgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
}

- (void)setModel:(HomeHotModel *)model {
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"misc_battery_power_ico"]];
    self.typeLabel.text = model.name ? model.name : model.rname;
    self.nameLabel.text = model.title;
    self.timesLabel.text = [NSString stringWithFormat:@"%ld观看",model.play];
}

@end
