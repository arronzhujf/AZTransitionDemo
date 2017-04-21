//
//  ViewController.m
//  AZTransitionDemo
//
//  Created by JianfengZhu on 2017/4/21.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "AZDefine.h"
#import "AZLinearDismissAnimation.h"
#import "AZLinearPresentAnimation.h"
#import "AZSwipeUpInteractiveTransition.h"
#import "AZPullDownInteractiveTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) AZLinearPresentAnimation *presentAnimation;
@property (nonatomic, strong) AZLinearDismissAnimation *dismissAnimation;
@property (nonatomic, strong) AZSwipeUpInteractiveTransition *swipeUpInteractiveTransition;
@property (nonatomic, strong) AZPullDownInteractiveTransition *pullDownInteractiveTransition;
@property (nonatomic, strong) ModalViewController *presentedVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    btn.center = self.view.center;
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn setTitle:@"click to present" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(presentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self initTransitionConfig];
}

- (void)initTransitionConfig {
    self.presentAnimation = [[AZLinearPresentAnimation alloc] init];
    self.dismissAnimation = [[AZLinearDismissAnimation alloc] init];
    self.swipeUpInteractiveTransition = [[AZSwipeUpInteractiveTransition alloc] init];
    self.pullDownInteractiveTransition = [[AZPullDownInteractiveTransition alloc] init];
    _presentedVC = [ModalViewController new];
    _presentedVC.transitioningDelegate = self;
    [self.swipeUpInteractiveTransition configForPresentedViewController:_presentedVC topMostView:_presentedVC.view presentingViewController:self topMostView:self.view];
    [self.pullDownInteractiveTransition configForPresentedViewController:_presentedVC topMostView:_presentedVC.view presentingViewController:self topMostView:self.view];
}

- (void)presentBtnClick:(UIButton *)sender {
    [self presentViewController:_presentedVC animated:YES completion:nil];
}

#pragma mark - Transition Delegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.swipeUpInteractiveTransition.interacting ? self.swipeUpInteractiveTransition : nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.pullDownInteractiveTransition.interacting ? self.pullDownInteractiveTransition: nil;
}

@end
