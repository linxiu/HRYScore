//
//  ViewController.m
//  HRYScore
//
//  Created by linxiu on 16/5/13.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "ViewController.h"
#import "HRYRateView.h"

@interface ViewController ()<HRYRateViewDelegate>
@property(nonatomic,strong)HRYRateView *rateView;
@property (nonatomic,strong) UILabel *mLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Score";
     [self configureView];
}
-(void)configureView{
    
    self.rateView = [[HRYRateView alloc]initWithFrame:CGRectMake(100, 100,300, 50)];
//    self.rateView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.rateView];
    
    [self.rateView setImageDeselected:@"shockedface2_empty" halfSelected:@"shockedface2_half"fullSelected:@"shockedface2_full" andDelegate:self];
   
    //显示结果的UILabel
    CGFloat labelX = (self.view.bounds.size.width - 400)*0.5f;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 400, 400, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.mLabel = label;
}
#pragma mark RWTRateViewDelegate

- (void)ratingBar:(HRYRateView *)ratingBar ratingChanged:(float)newRating{

    if (self.rateView == ratingBar) {
        self.mLabel.text = [NSString stringWithFormat:@"第一个评分条的当前结果为:%.1f",newRating];
    }
}
@end
