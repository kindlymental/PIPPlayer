//
//  HomeHeaderView.m
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()

// 文本
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(10);
    }];
}

- (void)setOuterModel:(HomeOuterModel *)outerModel {
    _outerModel = outerModel;
    
    self.textLabel.text = outerModel.title;
}

#pragma mark - 懒加载

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = ColorRGB(31, 31, 31);
        _textLabel.font = [UIFont systemFontOfSize:14];
    }
    return _textLabel;
}

@end
