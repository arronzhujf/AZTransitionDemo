//
//  SwipeUpInteractiveTransition.m
//  FlashFusion-iOS
//
//  Created by JianfengZhu on 2017/4/17.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import "AZSwipeUpInteractiveTransition.h"
#import "AZDefine.h"
@interface AZSwipeUpInteractiveTransition()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UINavigationController *presentedVC;
@property (nonatomic, weak) UIViewController *presentingVC;
@end

@implementation AZSwipeUpInteractiveTransition

- (void)configForPresentedViewController:(UIViewController *)presented
                             topMostView:(UIView *)presentedTopMostView
                presentingViewController:(UIViewController *)presenting
                             topMostView:(UIView *)presentingTopMostView {
    self.presentingVC = presenting;
    self.presentedVC = (UINavigationController *)presented;
    [self prepareGestureRecognizerInView:presentingTopMostView];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:panGesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC presentViewController:self.presentedVC animated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = -translation.y / SCREEN_HEIGHT;
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
