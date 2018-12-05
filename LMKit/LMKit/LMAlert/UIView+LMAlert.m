//
//  UIView+LMAlert.m
//  AudioWork
//
//  Created by lm on 2018/3/10.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "UIView+LMAlert.h"
#import "UIView+LMKitCategory.h"
@implementation UIView (LMAlert)

- (void)showInWindow
{
    [self showInWindowWithBackgoundTapDismissEnable:NO];
}

- (void)showInWindowWithBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [LMShowAlertView showAlertViewWithView:self backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY
{
    [self showInWindowWithOriginY:OriginY backgoundTapDismissEnable:NO];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [LMShowAlertView showAlertViewWithView:self originY:OriginY backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)hideInWindow
{
    if ([self isShowInWindow]) {
        [(LMShowAlertView *)self.superview hide];
    }else {
        NSLog(@"self.superview is nil, or isn't TYShowAlertView");
    }
}

#pragma mark - show in controller

- (void)showInController:(UIViewController *)viewController
{
    [self showInController:viewController preferredStyle:LMAlertControllerStyleAlert transitionAnimation:LMAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:LMAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:LMAlertTransitionAnimationFade backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:transitionAnimation backgoundTapDismissEnable:NO];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    LMAlertController *alertController = [LMAlertController alertControllerWithAlertView:self preferredStyle:preferredStyle transitionAnimation:transitionAnimation];
    alertController.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)hideInController
{
    if ([self isShowInAlertController]) {
        [(LMAlertController *)self.lm_viewController dismissViewControllerAnimated:YES];
    }else {
        NSLog(@"self.viewController is nil, or isn't TYAlertController");
    }
}

#pragma mark - hide

- (BOOL)isShowInAlertController
{
    UIViewController *viewController = self.lm_viewController;
    if (viewController && [viewController isKindOfClass:[LMAlertController class]]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)isShowInWindow
{
    if (self.superview && [self.superview isKindOfClass:[LMShowAlertView class]]) {
        return YES;
    }
    return NO;
}

- (void)hideView
{
    if ([self isShowInAlertController]) {
        [self hideInController];
    }else if ([self isShowInWindow]) {
        [self hideInWindow];
    }else {
        NSLog(@"self.viewController is nil, or isn't TYAlertController,or self.superview is nil, or isn't TYShowAlertView");
    }
}

@end
