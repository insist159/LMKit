//
//  LMBaseAnimation.h
//  LMAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAlertController.h"

@interface LMBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) BOOL isPresenting; // present . dismiss

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting;

// if you only want alert or actionsheet Style ,you can judge that you don't need and return nil
//  code : only support alert Style
//  if (preferredStyle == LMAlertControllerStyleAlert) {
//      return [super alertAnimationIsPresenting:isPresenting];
//  }
//  return nil;
+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(LMAlertControllerStyle) preferredStyle;


// override transiton time
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

// override present
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

// override dismiss
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
