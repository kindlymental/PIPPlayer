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

// 更多
@property (nonatomic,strong) UIButton *moreBtn;

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
    [self addSubview:self.moreBtn];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(10);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).mas_offset(-10);
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

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:ColorRGB(31, 31, 31) forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"---");
        }];
    }
    return _moreBtn;
}

@end
