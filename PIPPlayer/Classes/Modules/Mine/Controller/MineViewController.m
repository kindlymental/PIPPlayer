//
//  MineViewController.m
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

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
    
    self.nickNameLabel.text = @"兜里没糖";
}

@end
