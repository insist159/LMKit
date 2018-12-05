//
//  UIView+LMAlert.h
//  AudioWork
//
//  Created by lm on 2018/3/10.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAlertController.h"
#import "LMShowAlertView.h"
@interface UIView (LMAlert)

#pragma mark - show in controller

- (void)showInController:(UIViewController *)viewController;

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle;

// backgoundTapDismissEnable default NO
- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation;

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

#pragma mark - show in window

- (void)showInWindow;

// backgoundTapDismissEnable default NO
- (void)showInWindowWithBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)showInWindowWithOriginY:(CGFloat)OriginY;

- (void)showInWindowWithOriginY:(CGFloat)OriginY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;


#pragma mark - hide

// this will judge and call right method
- (void)hideView;

- (void)hideInController;

- (void)hideInWindow;

@end
