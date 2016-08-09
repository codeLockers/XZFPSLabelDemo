//
//  ViewController.m
//  XZFPSLabelDemo
//
//  Created by 徐章 on 16/8/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZFPSLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:[XZFPSLabel shareInstance]];
    [[XZFPSLabel shareInstance] start];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
