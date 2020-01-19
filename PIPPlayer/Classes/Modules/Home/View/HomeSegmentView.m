//
//  HomeSegmentView.m
//  PIPPlayer
//
//  Created by 刘怡兰 on 2020/1/9.
//  Copyright © 2020 com.lyl.demo. All rights reserved.
//

#import "HomeSegmentView.h"

@interface HomeSegmentView ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation HomeSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HomeSegmentView" owner:self options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
  
        [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    }
    return self;
}

- (IBAction)segmentChange:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    
    if ([self.delegate respondsToSelector:@selector(segmentChange:)]) {
        [self.delegate segmentChange:index];
    }
}


@end
