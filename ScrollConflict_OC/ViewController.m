//
//  ViewController.m
//  ScrollConflict_OC
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统导航左滑返回Demo（防卡死版）";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击跳转下一页" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 150, 50);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clicked:(UIButton *)sender {
    SecondVC *svc = [[SecondVC alloc] init];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController pushViewController:svc animated:YES];
}

@end
