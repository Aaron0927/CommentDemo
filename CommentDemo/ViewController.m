//
//  ViewController.m
//  CommentDemo
//
//  Created by xiaoerlong on 16/7/29.
//  Copyright © 2016年 xiaoerlong. All rights reserved.
//

#import "ViewController.h"
#import "BullerManager.h"
#import "BullerView.h"

@interface ViewController ()

@property (nonatomic, strong) BullerManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[BullerManager alloc] init];
    __weak typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(BullerView *view) {
        [weakSelf addBullerView:view];
    };
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 50, 50);
    [button setTitle:@"start" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 100, 50, 50);
    [btn setTitle:@"stop" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)start {
    [self.manager start];
}

- (void)stop {
    [self.manager stop];
}

- (void)addBullerView:(BullerView *)bullerView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    bullerView.frame = CGRectMake(width, 300 + bullerView.trajectory * 40, CGRectGetWidth(bullerView.bounds), CGRectGetHeight(bullerView.bounds));
    NSLog(@"width:%f", bullerView.frame.size.width);
    [self.view addSubview:bullerView];
    
    [bullerView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
