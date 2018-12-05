//
//  LMAlertController+TransitionAnimate.m
//  LMAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "LMAlertController.h"
#import "LMAlertFadeAnimation.h"
#import "LMAlertScaleFadeAnimation.h"
#import "LMAlertDropDownAnimation.h"

@implementation LMAlertController (TransitionAnimate)

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.transitionAnimation) {
        case LMAlertTransitionAnimationFade:
            return [LMAlertFadeAnimation alertAnimationIsPresenting:YES];
        case LMAlertTransitionAnimationScaleFade:
            return [LMAlertScaleFadeAnimation alertAnimationIsPresenting:YES];
        case LMAlertTransitionAnimationDropDown:
            return [LMAlertDropDownAnimation alertAnimationIsPresenting:YES];
        case LMAlertTransitionAnimationCustom:
            return [self.transitionAnimationClass alertAnimationIsPresenting:YES preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.transitionAnimation) {
        case LMAlertTransitionAnimationFade:
            return [LMAlertFadeAnimation alertAnimationIsPresenting:NO];
        case LMAlertTransitionAnimationScaleFade:
            return [LMAlertScaleFadeAnimation alertAnimationIsPresenting:NO];
        case LMAlertTransitionAnimationDropDown:
            return [LMAlertDropDownAnimation alertAnimationIsPresenting:NO];
        case LMAlertTransitionAnimationCustom:
            return [self.transitionAnimationClass alertAnimationIsPresenting:NO preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

@end
