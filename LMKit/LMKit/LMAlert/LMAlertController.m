//
//  LMAlertController.m
//  LMKit
//
//  Created by lm on 2018/3/7.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "LMAlertController.h"
#import "LMAlertViewConfig.h"
#import "UIView+LMKitCategory.h"
@interface LMAlertController ()

@property (nonatomic, assign) LMAlertControllerStyle preferredStyle;

@property (nonatomic, assign) LMAlertTransitionAnimation transitionAnimation;

@property (nonatomic, assign) Class transitionAnimationClass;

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, weak) UITapGestureRecognizer *singleTap;

@property (nonatomic, strong) NSLayoutConstraint *alertViewCenterYConstraint;

@property (nonatomic, assign) CGFloat alertViewCenterYOffset;

@end

@implementation LMAlertController

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        [self configureController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation transitionAnimationClass:(Class)transitionAnimationClass
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _alertView = alertView;
        _preferredStyle = preferredStyle;
        _transitionAnimation = transitionAnimation;
        _transitionAnimationClass = transitionAnimationClass;
    }
    return self;
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:LMAlertControllerStyleAlert
                      transitionAnimation:LMAlertTransitionAnimationFade
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:LMAlertTransitionAnimationFade
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimation:(LMAlertTransitionAnimation)transitionAnimation
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:transitionAnimation
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(LMAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:LMAlertTransitionAnimationCustom
                 transitionAnimationClass:transitionAnimationClass];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor clearColor];
    
    [self addBackgroundView];
    
    [self addSingleTapGesture];
    
    [self configureAlertView];
    
    [self.view layoutIfNeeded];
    
    if (_preferredStyle == LMAlertControllerStyleAlert) {
        // UIKeyboard Notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_viewWillShowHandler) {
        _viewWillShowHandler(_alertView);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_viewDidShowHandler) {
        _viewDidShowHandler(_alertView);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_viewWillHideHandler) {
        _viewWillHideHandler(_alertView);
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_viewDidHideHandler) {
        _viewDidHideHandler(_alertView);
    }
}

- (void)addBackgroundView
{
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = _backgroundColor;
        _backgroundView = backgroundView;
    }
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:_backgroundView atIndex:0];
    [self.view addConstraintToView:_backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = backgroundView;
    } else if (_backgroundView != backgroundView) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:backgroundView aboveSubview:_backgroundView];
        [self.view addConstraintToView:backgroundView edgeInset:UIEdgeInsetsZero];
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = backgroundView;
            [self addSingleTapGesture];
        }];
    }
}

- (void)addSingleTapGesture
{
    self.view.userInteractionEnabled = YES;
    _backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable;
    
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

#pragma mark - configure

- (void)configureController
{
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    LMAlertViewConfig * config = [LMAlertViewConfig globalConfig];
    
    _backgroundColor = config.alertControllerBackgroundColor;
    _backgoundTapDismissEnable = NO;
    _alertStyleEdging = config.alertStyleEdging;
    _actionSheetStyleEdging = config.actionSheetStyleEdging;
}

- (void)configureAlertView
{
    if (_alertView == nil) {
        NSLog(@"%@: alertView is nil",NSStringFromClass([self class]));
        return;
    }
    _alertView.userInteractionEnabled = YES;
    [self.view addSubview:_alertView];
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    switch (_preferredStyle) {
        case LMAlertControllerStyleActionSheet:
            [self layoutActionSheetStyleView];
            break;
        case LMAlertControllerStyleAlert:
            [self layoutAlertStyleView];
            break;
        default:
            break;
    }
}

- (void)configureAlertViewWidth
{
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
            [_alertView addConstraintWidth:CGRectGetWidth(self.view.frame)-2*_alertStyleEdging height:0];
        }
    }
}

#pragma mark - layout
- (void)layoutAlertStyleView
{
    // center X
    [self.view addConstraintCenterXToView:_alertView centerYToView:nil];
    
    [self configureAlertViewWidth];
    
    // top Y
    _alertViewCenterYConstraint = [self.view addConstraintCenterYToView:_alertView constant:0];
    
    if (_alertViewOriginY > 0) {
        [_alertView layoutIfNeeded];
        _alertViewCenterYOffset = _alertViewOriginY - (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_alertView.frame))/2;
        _alertViewCenterYConstraint.constant = _alertViewCenterYOffset;
    }else{
        _alertViewCenterYOffset = 0;
    }
}

- (void)layoutActionSheetStyleView
{
    // remove width constaint
    for (NSLayoutConstraint *constraint in _alertView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            [_alertView removeConstraint: constraint];
            break;
        }
    }
    
    // add edge constraint
    [self.view addConstraintWithView:_alertView topView:nil leftView:self.view bottomView:self.view rightView:self.view edgeInset:UIEdgeInsetsMake(0, _actionSheetStyleEdging, 0, -_actionSheetStyleEdging)];
    
    if (CGRectGetHeight(_alertView.frame) > 0) {
        // height
        [_alertView addConstraintWidth:0 height:CGRectGetHeight(_alertView.frame)];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:YES completion:self.dismissComplete];
}

#pragma mark - action

- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES];
}

#pragma mark - notification

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat alertViewBottomEdge = (CGRectGetHeight(self.view.frame) -  CGRectGetHeight(_alertView.frame))/2 - _alertViewCenterYOffset;
    
    //当开启热点时，向下偏移20px
    //修复键盘遮挡问题
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat differ = CGRectGetHeight(keyboardRect) - alertViewBottomEdge;
    
    //修复：输入框获取焦点时，会重复刷新，导致输入框文章偏移一下
    if (_alertViewCenterYConstraint.constant == -differ -statusBarHeight) {
        return;
    }
    
    if (differ >= 0) {
        _alertViewCenterYConstraint.constant = _alertViewCenterYOffset - differ - statusBarHeight;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}


- (void)keyboardWillHide:(NSNotification*)notification
{
    _alertViewCenterYConstraint.constant = _alertViewCenterYOffset;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
