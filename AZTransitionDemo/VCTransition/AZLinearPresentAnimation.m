//
//  LinearPresentAnimation.m
//  FlashFusion-iOS
//
//  Created by JianfengZhu on 2017/4/17.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import "AZLinearPresentAnimation.h"
#import "AZDefine.h"
@implementation AZLinearPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toVC.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        toVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
