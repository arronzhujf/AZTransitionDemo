//
//  SwipeUpInteractiveTransition.h
//  FlashFusion-iOS
//
//  Created by JianfengZhu on 2017/4/17.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZSwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (void)configForPresentedViewController:(UIViewController *)presented
                             topMostView:(UIView *)presentedTopMostView
                presentingViewController:(UIViewController *)presenting
                             topMostView:(UIView *)presentingTopMostView;
@end
