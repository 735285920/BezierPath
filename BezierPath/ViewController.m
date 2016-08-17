//
//  ViewController.m
//  BezierPath
//
//  Created by shumei on 16/8/5.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "ViewController.h"
#import "BazierPathView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BazierPathView * view = [[BazierPathView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
