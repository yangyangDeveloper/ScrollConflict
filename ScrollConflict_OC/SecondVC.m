//
//  SecondVC.m
//  ScrollConflict
//
//  Created by Tech-zhangyangyang on 2017/4/25.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import "SecondVC.h"
#import "CustomScrollView.h"

@interface SecondVC ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation SecondVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 监听系统的左滑返回事件
    if (![[self.navigationController viewControllers] containsObject:self]) {
        NSLog(@"正在popping回上层....");
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if ([self.navigationController.viewControllers count] == 2) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"左滑返回+scrollview+slider";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 消除scrollview偏移64
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    UIImage *backImage   = [UIImage imageNamed:@"btn_back"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,60,30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    
    CustomScrollView *scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width *5, 200);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width *i, 0, self.view.frame.size.width, 200)];
        label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        label.text = [NSString stringWithFormat:@"scrollview第%d页面",i];
        [scrollView addSubview:label];
    }
    
    // 添加一个slider 用于演示 左滑返回手势 和slider滑动手势 以及 scrollview自身的左右滑动手势
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(0, 20, 200, 60)];
    slider1.backgroundColor = [UIColor greenColor];
    [slider1 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:slider1];
    [self.view addSubview:scrollView];
    
    // 添加一个slider 用于演示 左滑返回和slider 手势
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 300, 150, 60)];
    slider.backgroundColor = [UIColor greenColor];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if([touch.view isKindOfClass:[UISlider class]])
        return NO;
    else
        return YES;
}

- (void)sliderValueChanged:(id)sender {
    NSLog(@"正在操作视图slider") ;
}

- (void)doClickBackAction:(UIButton *)sender {
    NSLog(@"正在popping回上层....");
    [self.navigationController popViewControllerAnimated:YES];
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll %@",NSStringFromCGPoint(scrollView.contentOffset));
}

@end
