//
//  LMAlertController.h
//  LMKit
//
//  Created by lm on 2018/3/7.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LMAlertControllerStyle) {
    LMAlertControllerStyleAlert = 0,
    LMAlertControllerStyleActionSheet
};

typedef NS_ENUM(NSInteger, LMAlertTransitionAnimation) {
    LMAlertTransitionAnimationFade = 0,
    LMAlertTransitionAnimationScaleFade,
    LMAlertTransitionAnimationDropDown,
    LMAlertTransitionAnimationCustom
};

@interface LMAlertController : UIViewController

@property (nonatomic, strong, readonly) UIView *alertView;

@property (nonatomic, strong) UIColor *backgroundColor; // set backgroundColor
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign, readonly) LMAlertControllerStyle preferredStyle;

@property (nonatomic, assign, readonly) LMAlertTransitionAnimation transitionAnimation;

@property (nonatomic, assign, readonly) Class transitionAnimationClass;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

@property (nonatomic, assign) CGFloat alertViewOriginY;  // default center Y

@property (nonatomic, assign) CGFloat alertStyleEdging; //  when width frame equal to 0,or no width constraint ,this proprty will use, default to 15 edge
@property (nonatomic, assign) CGFloat actionSheetStyleEdging;

// alertView lifecycle block
@property (copy, nonatomic) void (^viewWillShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewWillHideHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidHideHandler)(UIView *alertView);

// dismiss controller completed block
@property (nonatomic, copy) void (^dismissComplete)(void);

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass;

- (void)dismissViewControllerAnimated: (BOOL)animated;

@end

// Transition Animate
@interface LMAlertController (TransitionAnimate)<UIViewControllerTransitioningDelegate>

@end
