//
//  LMShowAlertView.m
//  AudioWork
//
//  Created by lm on 2018/3/10.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "LMShowAlertView.h"
#import "UIView+LMKitCategory.h"
#import "LMUtilsMacros.h"
@interface LMShowAlertView ()
@property (nonatomic, weak) UIView *alertView;
@property (nonatomic, weak) UITapGestureRecognizer *singleTap;
@end

@implementation LMShowAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgoundTapDismissEnable = NO;
        _alertViewEdging = 15;
        
        [self addBackgroundView];
        
        [self addSingleGesture];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)tipView
{
    if (self = [self initWithFrame:CGRectZero]) {
        
        [self addSubview:tipView];
        _alertView = tipView;
    }
    return self;
}

+ (instancetype)alertViewWithView:(UIView *)tipView
{
    return [[self alloc]initWithAlertView:tipView];
}

+ (void)showAlertViewWithView:(UIView *)alertView
{
    [self showAlertViewWithView:alertView backgoundTapDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    LMShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [showTipView show];
}

+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY
{
    [self showAlertViewWithView:alertView
                        originY:originY backgoundTapDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    LMShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.alertViewOriginY = originY;
    showTipView.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [showTipView show];
}

- (void)addBackgroundView
{
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _backgroundView = backgroundView;
    }
    [self insertSubview:_backgroundView atIndex:0];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintToView:_backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addBackgroundView];
        [self addSingleGesture];
    }
}
- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview addConstraintToView:self edgeInset:UIEdgeInsetsZero];
        [self layoutAlertView];
    }
}

- (void)layoutAlertView
{
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    // center X
    [self addConstraintCenterXToView:_alertView centerYToView:nil];
    
    // width, height
    if (!CGSizeEqualToSize(_alertView.frame.size,CGSizeZero)) {
        [_alertView addConstraintWidth:CGRectGetWidth(_alertView.frame) height:CGRectGetHeight(_alertView.frame)];
        
    }else {
        BOOL findAlertViewWidthConstraint = NO;
        for (NSLayoutConstraint *constraint in _alertView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidthConstraint = YES;
                break;
            }
        }
        
        if (!findAlertViewWidthConstraint) {
            [_alertView addConstraintWidth:CGRectGetWidth(self.superview.frame)-2*_alertViewEdging height:0];
        }
    }
    
    // topY
    NSLayoutConstraint *alertViewCenterYConstraint = [self addConstraintCenterYToView:_alertView constant:0];
    
    if (_alertViewOriginY > 0) {
        [_alertView layoutIfNeeded];
        alertViewCenterYConstraint.constant = _alertViewOriginY - (CGRectGetHeight(self.superview.frame) - CGRectGetHeight(_alertView.frame))/2;
    }
}

#pragma mark - add Gesture
- (void)addSingleGesture
{
    self.userInteractionEnabled = YES;
    //单指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable;
    //增加事件者响应者，
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

#pragma mark 手指点击事件
- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}

- (void)show
{
    if (self.superview == nil) {
        [kAppWindow addSubview:self];
    }
    self.alpha = 0;
    _alertView.transform = CGAffineTransformScale(_alertView.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
    
}

- (void)hide
{
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            _alertView.transform = CGAffineTransformScale(_alertView.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

@end
