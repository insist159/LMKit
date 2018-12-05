//
//  UIView+LMKitCategory.m
//  LMKit
//
//  Created by lm on 2018/3/6.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "UIView+LMKitCategory.h"

#define degToRad(x) (M_PI * (x) / 180.0)

typedef NS_ENUM(NSInteger, EdgeType) {
    TopBorder = 10000,
    LeftBorder = 20000,
    BottomBorder = 30000,
    RightBorder = 40000
};

@implementation UIView (LMKitCategory)

- (void)addConstraintToView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset
{
    [self addConstraintWithView:view topView:self leftView:self bottomView:self rightView:self edgeInset:edgeInset];
}

- (void)addConstraintWithView:(UIView *)view topView:(UIView *)topView leftView:(UIView *)leftView
                   bottomView:(UIView *)bottomView rightView:(UIView *)rightView edgeInset:(UIEdgeInsets)edgeInset
{
    if (topView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    }
    
    if (leftView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    }
    
    if (rightView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
    }
    
    if (bottomView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
    }
}

- (void)addConstraintWithLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1 constant:-constant]];
}

- (NSLayoutConstraint *)addConstraintWithTopView:(UIView *)topView toBottomView:(UIView *)bottomView constant:(CGFloat)constant
{
    NSLayoutConstraint *topBottomConstraint =[NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeTop multiplier:1 constant:-constant];
    [self addConstraint:topBottomConstraint];
    return topBottomConstraint;
}

- (void)addConstraintWidth:(CGFloat)width height:(CGFloat)height
{
    if (width > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:width]];
    }
    
    if (height > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:height]];
    }
}

- (void)addConstraintEqualWithView:(UIView *)view widthToView:(UIView *)wView heightToView:(UIView *)hView
{
    if (wView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:wView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    }
    
    if (hView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    }
}

- (void)addConstraintCenterXToView:(UIView *)xView centerYToView:(UIView *)yView
{
    if (xView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:xView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    }
    
    if (yView) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:yView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }
}

- (NSLayoutConstraint *)addConstraintCenterYToView:(UIView *)yView constant:(CGFloat)constant;
{
    if (yView) {
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:yView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:constant];
        [self addConstraint:centerYConstraint];
        return centerYConstraint;
    }
    return nil;
}

- (void)removeConstraintWithAttribte:(NSLayoutAttribute)attr
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attr) {
            [self removeConstraint:constraint];
            break;
        }
    }
}

- (void)removeConstraintWithView:(UIView *)view attribute:(NSLayoutAttribute)attr
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attr && constraint.firstItem == view) {
            [self removeConstraint:constraint];
            break;
        }
    }
}

- (void)removeAllConstraints
{
    [self removeConstraints:self.constraints];
}

#pragma mark boder
- (void)lm_removeTopBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == TopBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)lm_removeLeftBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == LeftBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)lm_removeBottomBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == BottomBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)lm_removeRightBorder {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (subView.tag == RightBorder) {
            [subView removeFromSuperview];
        }
    }];
}

- (void)lm_addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self lm_addTopBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)lm_addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self lm_addLeftBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)lm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth {
    [self lm_addBottomBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)lm_addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    [self lm_addRightBorderWithColor:color width:borderWidth excludePoint:0 edgeType:0];
}


- (void)lm_addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge {
    [self lm_removeTopBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = TopBorder;
    
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & ExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & ExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLenght = self.bounds.size.width - endPoint - startPoint;
        border.frame = CGRectMake(startPoint, 0.0, borderLenght, borderWidth);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}


- (void)lm_addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge {
    [self lm_removeLeftBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = LeftBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & ExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & ExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.height - startPoint - endPoint;
        border.frame = CGRectMake(0.0, startPoint, borderWidth, borderLength);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
    
}


- (void)lm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge {
    [self lm_removeBottomBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = BottomBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & ExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & ExcludeEndPoint) {
        endPoint += point;
    }
    
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.width - startPoint - endPoint;
        border.frame = CGRectMake(startPoint, self.bounds.size.height - borderWidth, borderLength, borderWidth);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}

- (void)lm_addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge {
    [self lm_removeRightBorder];
    
    UIView *border = [[UIView alloc] init];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        border.translatesAutoresizingMaskIntoConstraints = NO;
    }
    border.userInteractionEnabled = NO;
    border.backgroundColor = color;
    border.tag = RightBorder;
    [self addSubview:border];
    
    CGFloat startPoint = 0.0f;
    CGFloat endPoint = 0.0f;
    if (edge & ExcludeStartPoint) {
        startPoint += point;
    }
    
    if (edge & ExcludeEndPoint) {
        endPoint += point;
    }
    
    if (border.translatesAutoresizingMaskIntoConstraints) {
        CGFloat borderLength = self.bounds.size.height - startPoint - endPoint;
        border.frame = CGRectMake(self.bounds.size.width - borderWidth, startPoint, borderWidth, borderLength);
        return;
    }
    
    // AutoLayout
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:startPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-endPoint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:border attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:borderWidth]];
}

#pragma mark loadnib
+ (UINib *)lm_loadNib
{
    return [self lm_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)lm_loadNibNamed:(NSString*)nibName
{
    return [self lm_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)lm_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)lm_loadInstanceFromNib
{
    return [self lm_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self lm_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self lm_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}


#pragma mark Screenhot
- (void)lm_makeRadius:(CGFloat)radius {
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = radius;
}

-(void)lm_cornerRadius: (CGFloat)radius strokeSize: (CGFloat)size color: (UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = size;
    self.layer.masksToBounds = true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)lm_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius
{
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration
{
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
    self.alpha = 0.0;
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_addSubview: (UIView *)subview withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration
{
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationTransition: transition forView: self cache: YES];
    [self addSubview: subview];
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration
{
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationDuration: duration];
    [UIView setAnimationTransition: transition forView: self.superview cache: YES];
    [self removeFromSuperview];
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_rotateByAngle: (CGFloat)angle
            duration: (NSTimeInterval)duration
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
    rotation.toValue = [NSNumber numberWithFloat: degToRad(angle)];
    rotation.duration = duration;
    rotation.repeatCount = repeatCount;
    rotation.autoreverses = autoreverse;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeBoth;
    rotation.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: rotation forKey: @"rotationAnimation"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)lm_moveToPoint: (CGPoint)newPoint
          duration: (NSTimeInterval)duration
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction
{
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath: @"position"];
    move.toValue = [NSValue valueWithCGPoint: newPoint];
    move.duration = duration;
    move.removedOnCompletion = NO;
    move.repeatCount = repeatCount;
    move.autoreverses = autoreverse;
    move.fillMode = kCAFillModeBoth;
    move.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: move forKey: @"positionAnimation"];
}

/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)lm_viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (CGFloat)lm_left {
    return self.frame.origin.x;
}

- (void)setLm_left:(CGFloat)lm_left {
    CGRect frame = self.frame;
    frame.origin.x = lm_left;
    self.frame = frame;
}

- (CGFloat)lm_top {
    return self.frame.origin.y;
}

- (void)setLm_top:(CGFloat)lm_top {
    CGRect frame = self.frame;
    frame.origin.y = lm_top;
    self.frame = frame;
}

- (CGFloat)lm_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLm_right:(CGFloat)lm_right {
    CGRect frame = self.frame;
    frame.origin.x = lm_right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)lm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLm_bottom:(CGFloat)lm_bottom {
    CGRect frame = self.frame;
    frame.origin.y = lm_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lm_width {
    return self.frame.size.width;
}

- (void)setLm_width:(CGFloat)lm_width {
    CGRect frame = self.frame;
    frame.size.width = lm_width;
    self.frame = frame;
}

- (CGFloat)lm_height {
    return self.frame.size.height;
}

- (void)setLm_height:(CGFloat)lm_height {
    CGRect frame = self.frame;
    frame.size.height = lm_height;
    self.frame = frame;
}

- (CGFloat)lm_centerX {
    return self.center.x;
}

- (void)setLm_centerX:(CGFloat)lm_centerX {
    self.center = CGPointMake(lm_centerX, self.center.y);
}

- (CGFloat)lm_centerY {
    return self.center.y;
}

- (void)setLm_centerY:(CGFloat)lm_centerY {
    self.center = CGPointMake(self.center.x, lm_centerY);
}

- (CGPoint)lm_origin {
    return self.frame.origin;
}

- (void)setLm_origin:(CGPoint)lm_origin {
    CGRect frame = self.frame;
    frame.origin = lm_origin;
    self.frame = frame;
}

- (CGSize)lm_size {
    return self.frame.size;
}

- (void)setLm_size:(CGSize)lm_size {
    CGRect frame = self.frame;
    frame.size = lm_size;
    self.frame = frame;
}


@end
