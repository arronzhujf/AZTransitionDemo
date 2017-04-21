//
//  ModalViewController.m
//  AZTransitionDemo
//
//  Created by JianfengZhu on 2017/4/21.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)dismissBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
