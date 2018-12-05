//
//  UIView+LMKitCategory.h
//  LMKit
//
//  Created by lm on 2018/3/6.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ExcludePoint) {
    ExcludeStartPoint = 1 << 0,
    ExcludeEndPoint = 1 << 1,
    ExcludeAllPoint = ~0UL
};

@interface UIView (LMKitCategory)

- (void)addConstraintToView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

- (void)addConstraintWithView:(UIView *)view topView:(UIView *)topView leftView:(UIView *)leftView
                   bottomView:(UIView *)bottomView rightView:(UIView *)rightView edgeInset:(UIEdgeInsets)edgeInset;

- (void)addConstraintWithLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant;

- (NSLayoutConstraint *)addConstraintWithTopView:(UIView *)topView toBottomView:(UIView *)bottomView constant:(CGFloat)constant;

- (void)addConstraintWidth:(CGFloat)width height:(CGFloat)height;

- (void)addConstraintEqualWithView:(UIView *)view widthToView:(UIView *)wView heightToView:(UIView *)hView;

- (NSLayoutConstraint *)addConstraintCenterYToView:(UIView *)yView constant:(CGFloat)constant;

- (void)addConstraintCenterXToView:(UIView *)xView centerYToView:(UIView *)yView;

- (void)removeConstraintWithAttribte:(NSLayoutAttribute)attr;

- (void)removeConstraintWithView:(UIView *)view attribute:(NSLayoutAttribute)attr;

- (void)removeAllConstraints;


//border
- (void)lm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)lm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)lm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)lm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)lm_removeTopBorder;
- (void)lm_removeLeftBorder;
- (void)lm_removeBottomBorder;
- (void)lm_removeRightBorder;


- (void)lm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge;
- (void)lm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge;
- (void)lm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge;
- (void)lm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ExcludePoint)edge;


//load nib
+ (UINib *)lm_loadNib;
+ (UINib *)lm_loadNibNamed:(NSString*)nibName;
+ (UINib *)lm_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;
+ (instancetype)lm_loadInstanceFromNib;
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)lm_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

/**
 *  view加圆角
 */
- (void)lm_makeRadius:(CGFloat)radius;




/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)lm_cornerRadius: (CGFloat)radius
         strokeSize: (CGFloat)size
              color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)lm_setRoundedCorners:(UIRectCorner)corners
                  radius:(CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)lm_shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)lm_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)lm_addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)lm_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)lm_rotateByAngle: (CGFloat)angle
            duration: (NSTimeInterval)duration
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)lm_moveToPoint: (CGPoint)newPoint
          duration: (NSTimeInterval)duration
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction;


/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *lm_viewController;

@property (nonatomic) CGFloat lm_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat lm_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat lm_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat lm_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat lm_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat lm_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat lm_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat lm_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint lm_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  lm_size;        ///< Shortcut for frame.size.

@end





