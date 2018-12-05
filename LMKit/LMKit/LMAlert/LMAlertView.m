//
//  LMAlertView.m
//  LMKit
//
//  Created by lm on 2018/3/1.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "LMAlertView.h"
#import "LMAlertViewConfig.h"
#import "LMKitCategory.h"
#import "UIView+LMAlert.h"
#define kButtonTagOffset 1000
#define kTextFieldOffset 10000

@interface LMAlertAction ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) LMAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(LMAlertAction *);
@end

@implementation LMAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(LMAlertActionStyle)style handler:(void (^)(LMAlertAction *))handler
{
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(LMAlertActionStyle)style handler:(void (^)(LMAlertAction *))handler
{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
        _enabled = YES;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    LMAlertAction *action = [[self class]allocWithZone:zone];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end

@interface LMAlertView ()

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIView *textFieldContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFieldTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, strong) NSMutableArray *textFieldSeparateViews;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;

@end

@implementation LMAlertView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self configureProperty];
        
        [self addContentViews];
        
        [self addTextLabels];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [self init]) {
        
        _titleLable.text = title;
        _messageLabel.text = message;
        
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}

#pragma mark SET

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLable.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLable.textColor = titleColor;
}

-(void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    _messageLabel.font = _messageFont;
}

- (void)setMessageColor:(UIColor *)messageColor {
    _messageColor = messageColor;
    _messageLabel.textColor = _messageColor;
}

- (void)setContentViewBgColor:(UIColor *)contentViewBgColor {
    _contentViewBgColor = contentViewBgColor;
    self.backgroundColor = contentViewBgColor;
}

- (void)setContentViewCornerRadius:(CGFloat)contentViewCornerRadius {
    _contentViewCornerRadius = contentViewCornerRadius;
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = _contentViewCornerRadius;
}

#pragma mark - configure

- (void)configureProperty {
    
    LMAlertViewConfig * config = [LMAlertViewConfig globalConfig];
    
    _clickedAutoHide = YES;
    
    _contentViewCornerRadius = config.contentViewCornerRadius;
    _contentViewBgColor = config.contentViewBgColor;
    
    _titleFont = config.titleFont;
    _titleColor = config.titleColor;
    
    _messageFont = config.messageFont;
    _messageColor = config.messageColor;
    
    _alertViewWidth = config.alertViewWidth;
    _contentViewSpace = config.contentViewSpace;
    _textLabelSpace = config.textLabelSpace;
    _textLabelContentViewEdge = config.textLabelContentViewEdge;
    _buttonHeight = config.buttonHeight;
    _buttonSpace = config.buttonSpace;
    _buttonContentViewEdge = config.buttonContentViewEdge;
    _buttonContentViewTop = config.buttonContentViewTop;
    _buttonCornerRadius = config.buttonCornerRadius;
    
    _buttonDefaultBorderWidth = config.buttonDefaultBorderWidth;
    _buttonDefaultBorderColor = config.buttonDefaultBorderColor;
    
    _buttonCancelBorderWidth = config.buttonCancelBorderWidth;
    _buttonCancelBorderColor = config.buttonCancelBorderColor;
    
    _buttonDestructiveBorderWidth = config.buttonDestructiveBorderWidth;
    _buttonDestructiveBorderColor = config.buttonDestructiveBorderColor;
    
    _buttonFont = config.buttonFont;
    
    _buttonDefaultTitleColor = config.buttonDefaultTitleColor;
    _buttonCancelTitleColor = config.buttonCancelTitleColor;
    _buttonDestructiveTitleColor = config.buttonDestructiveTitleColor;
    
    _buttonDefaultTitleColorForHigh = config.buttonDefaultTitleColorForHigh;
    _buttonCancelTitleColorForHigh = config.buttonCancelTitleColorForHigh;
    _buttonDestructiveTitleColorForHigh = config.buttonDestructiveTitleColorForHigh;
    
    _buttonDefaultBgColor = config.buttonDefaultBgColor;
    _buttonCancelBgColor = config.buttonCancelBgColor;
    _buttonDestructiveBgColor = config.buttonDestructiveBgColor;
    
    _buttonDefaultBgColorForHigh = config.buttonDefaultBgColorForHigh;
    _buttonCancelBgColorForHigh = config.buttonCancelBgColorForHigh;
    _buttonDestructiveBgColorForHigh = config.buttonDestructiveBgColorForHigh;
    
    
    
    _textFieldHeight = config.textFieldHeight;
    _textFieldEdge = config.textFieldEdge;
    _textFieldBorderWidth = config.textFieldBorderWidth;
    _textFieldContentViewEdge = config.textFieldContentViewEdge;
    _textFieldCornerRadius = config.textFieldCornerRadius;
    _textFieldBorderColor = config.textFieldBorderColor;
    _textFieldBackgroudColor = config.textFieldBackgroudColor;
    _textFieldFont = config.textFieldFont;
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
    
}

- (UIColor *)buttonBgColorWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case LMAlertActionStyleCancel:
            return _buttonCancelBgColor;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
}

- (UIColor *)buttonBgForHighColorWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultBgColorForHigh;
        case LMAlertActionStyleCancel:
            return _buttonCancelBgColorForHigh;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveBgColorForHigh;
            
        default:
            return nil;
    }
}

- (UIColor *)buttonTitleColorWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultTitleColor;
        case LMAlertActionStyleCancel:
            return _buttonCancelTitleColor;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveTitleColor;
            
        default:
            return nil;
    }
}

- (UIColor *)buttonTitleForHighColorWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultTitleColorForHigh;
        case LMAlertActionStyleCancel:
            return _buttonCancelTitleColorForHigh;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveTitleColorForHigh;
            
        default:
            return nil;
    }
}

- (CGFloat )buttonBorderWidthWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultBorderWidth;
        case LMAlertActionStyleCancel:
            return _buttonCancelBorderWidth;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveBorderWidth;
            
        default:
            return 0;
    }
}

- (UIColor *)buttonBorderColorWithStyle:(LMAlertActionStyle)style
{
    switch (style) {
        case LMAlertActionStyleDefault:
            return _buttonDefaultBorderColor;
        case LMAlertActionStyleCancel:
            return _buttonCancelBorderColor;
        case LMAlertActionStyleDestructive:
            return _buttonDestructiveBorderColor;
            
        default:
            return nil;
    }
}

#pragma mark - add contentview
- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContentView = [[UIView alloc]init];
    [self addSubview:textFieldContentView];
    _textFieldContentView = textFieldContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
    
    self.backgroundColor = _contentViewBgColor;
    
    if (_contentViewCornerRadius > 0) {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = _contentViewCornerRadius;
    }
}

- (void)addTextLabels
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = _titleFont;
    titleLabel.textColor = _titleColor;
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = _messageFont;
    messageLabel.textColor = _messageColor;
    [_textContentView addSubview:messageLabel];
    _messageLabel = messageLabel;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}

- (void)addAction:(LMAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = _buttonCornerRadius;
    [button setTitle:action.title forState:UIControlStateNormal];
    [button setTitle:action.title forState:UIControlStateHighlighted];
    button.titleLabel.font = _buttonFont;
    [button setBackgroundImage:[UIImage lm_imageWithColor:[self buttonBgColorWithStyle:action.style]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage lm_imageWithColor:[self buttonBgForHighColorWithStyle:action.style]] forState:UIControlStateHighlighted];
    [button setTitleColor:[self buttonTitleColorWithStyle:action.style] forState:UIControlStateNormal];
    [button setTitleColor:[self buttonTitleForHighColorWithStyle:action.style] forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = [self buttonBorderWidthWithStyle:action.style];
    button.layer.borderColor = [self buttonBorderColorWithStyle:action.style].CGColor;
    
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }

    [self layoutButtons];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    if (_textFields == nil) {
        _textFields = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFieldOffset + _textFields.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFieldContentView addSubview:textField];
    [_textFields addObject:textField];
    
    if (_textFields.count > 1) {
        if (_textFieldSeparateViews == nil) {
            _textFieldSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFieldContentView addSubview:separateView];
        [_textFieldSeparateViews addObject:separateView];
    }
    
    [self layoutTextFields];
}

- (NSArray *)textFieldArray
{
    return _textFields;
}

#pragma mark - layout contenview
- (void)layoutContentViews
{
    if (!_textContentView.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    if (_alertViewWidth) {
        [self addConstraintWidth:_alertViewWidth height:0];
    }
    
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(_contentViewSpace, _textLabelContentViewEdge, 0, -_textLabelContentViewEdge)];
    
    // textFieldContentView
    _textFieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _textFieldTopConstraint = [self addConstraintWithTopView:_textContentView toBottomView:_textFieldContentView constant:0];
    
    [self addConstraintWithView:_textFieldContentView topView:nil leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, _textFieldContentViewEdge, 0, -_textFieldContentViewEdge)];
    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _buttonTopConstraint = [self addConstraintWithTopView:_textFieldContentView toBottomView:_buttonContentView constant:_buttonContentViewTop];
    
    [self addConstraintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsMake(0, _buttonContentViewEdge, -_contentViewSpace, -_buttonContentViewEdge)];
}

- (void)layoutTextLabels
{
    if (!_titleLable.translatesAutoresizingMaskIntoConstraints && !_messageLabel.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    // title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edgeInset:UIEdgeInsetsZero];
    
    // message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithTopView:_titleLable toBottomView:_messageLabel constant:_textLabelSpace];
    [_textContentView addConstraintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edgeInset:UIEdgeInsetsZero];
}

- (void)layoutButtons
{
    UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        _buttonTopConstraint.constant = -_buttonContentViewTop;
        [_buttonContentView addConstraintToView:button edgeInset:UIEdgeInsetsZero];
        [button addConstraintWidth:0 height:_buttonHeight];
    }else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [_buttonContentView removeConstraintWithView:firstButton attribute:NSLayoutAttributeRight];
        [_buttonContentView addConstraintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
        [_buttonContentView addConstraintWithLeftView:firstButton toRightView:button constant:_buttonSpace];
        [_buttonContentView addConstraintEqualWithView:button widthToView:firstButton heightToView:firstButton];
    }else {
        if (_buttons.count == 3) {
            UIButton *firstBtn = _buttons[0];
            UIButton *secondBtn = _buttons[1];
            [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeRight];
            [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeBottom];
            [_buttonContentView removeConstraintWithView:secondBtn attribute:NSLayoutAttributeTop];
            [_buttonContentView addConstraintWithView:firstBtn topView:nil leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
            [_buttonContentView addConstraintWithTopView:firstBtn toBottomView:secondBtn constant:_buttonSpace];
            
        }
        
        UIButton *lastSecondBtn = _buttons[_buttons.count - 2];
        [_buttonContentView removeConstraintWithView:lastSecondBtn attribute:NSLayoutAttributeBottom];
        [_buttonContentView addConstraintWithTopView:lastSecondBtn toBottomView:button constant:_buttonSpace];
        [_buttonContentView addConstraintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
        [_buttonContentView addConstraintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
    }
}

- (void)layoutTextFields
{
    UITextField *textField = _textFields.lastObject;
    
    if (_textFields.count == 1) {
        _textFieldContentView.backgroundColor = _textFieldBackgroudColor;
        _textFieldContentView.layer.masksToBounds = YES;
        _textFieldContentView.layer.cornerRadius = _textFieldCornerRadius;
        _textFieldContentView.layer.borderWidth = _textFieldBorderWidth;
        _textFieldContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        _textFieldTopConstraint.constant = -_contentViewSpace;
        [_textFieldContentView addConstraintToView:textField edgeInset:UIEdgeInsetsMake(_textFieldBorderWidth, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [textField addConstraintWidth:0 height:_textFieldHeight];
    } else {
        UITextField *lastSecondTextField = _textFields[_textFields.count - 2];
        [_textFieldContentView removeConstraintWithView:lastSecondTextField attribute:NSLayoutAttributeBottom];
        [_textFieldContentView addConstraintWithTopView:lastSecondTextField toBottomView:textField constant:_textFieldBorderWidth];
        [_textFieldContentView addConstraintWithView:textField topView:nil leftView:_textFieldContentView bottomView:_textFieldContentView rightView:_textFieldContentView edgeInset:UIEdgeInsetsMake(0, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [_textFieldContentView addConstraintEqualWithView:textField widthToView:nil heightToView:lastSecondTextField];
        
        // separateview
        UIView *separateView = _textFieldSeparateViews[_textFields.count - 2];
        [_textFieldContentView addConstraintWithView:separateView topView:nil leftView:_textFieldContentView bottomView:nil rightView:_textFieldContentView edgeInset:UIEdgeInsetsZero];
        [_textFieldContentView addConstraintWithTopView:separateView toBottomView:textField constant:0];
        [separateView addConstraintWidth:0 height:_textFieldBorderWidth];
    }
    
}

- (void)actionButtonClicked:(UIButton *)button
{
    LMAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    if (_clickedAutoHide) {
        [self hideView];
    }
    
    if (action.handler) {
        action.handler(action);
    }
}

@end
