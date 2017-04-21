//
//  PullDownInteractiveTransition.m
//  FlashFusion-iOS
//
//  Created by JianfengZhu on 2017/4/17.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import "AZPullDownInteractiveTransition.h"
#import "AZDefine.h"
@interface AZPullDownInteractiveTransition()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UIViewController *presentedVC;
@property (nonatomic, weak) UIViewController *presentingVC;
@end

@implementation AZPullDownInteractiveTransition
- (void)configForPresentedViewController:(UIViewController *)presented
                             topMostView:(UIView *)presentedTopMostView
                presentingViewController:(UIViewController *)presenting
                             topMostView:(UIView *)presentingTopMostView {
    self.presentedVC = presented;
    self.presentingVC = presenting;
    [self prepareGestureRecognizerInView:presentedTopMostView];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.y / SCREEN_HEIGHT;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.3);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
            if (velocity.y < -1000) {
                self.interacting = NO;
                [self finishInteractiveTransition];
                break;
            }
        }
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
@end
