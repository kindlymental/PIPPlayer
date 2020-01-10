//
//  MineViewController.m
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation MineViewController

// 需要初始化的时候就设置好title
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.clearColor;
    self.iconImgView.layer.masksToBounds = YES;
    self.iconImgView.layer.cornerRadius = 35;
    
    self.nickNameLabel.text = @"兜里没糖";
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
    [self.bgView addGestureRecognizer:gesture];
    
}

- (void)viewClick:(UIView *)view {
    NSLog(@"--%@",view);
}

- (IBAction)buttonAction:(id)sender {
    NSLog(@"%@",sender);
}

@end
