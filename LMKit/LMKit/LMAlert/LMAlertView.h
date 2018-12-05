//
//  LMAlertView.h
//  LMKit
//
//  Created by lm on 2018/3/1.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LMAlertActionStyle) {
    LMAlertActionStyleDefault,
    LMAlertActionStyleCancel,
    LMAlertActionStyleDestructive,
};

@interface LMAlertAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(LMAlertActionStyle)style handler:(void (^)(LMAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) LMAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface LMAlertView : UIView

@property (nonatomic, weak, readonly) UILabel *titleLable;
@property (nonatomic, weak, readonly) UILabel *messageLabel;

// alertView textfield array
@property (nonatomic, strong, readonly) NSArray *textFieldArray;

@property (nonatomic, assign) CGFloat contentViewCornerRadius;
@property (nonatomic,copy) UIColor *contentViewBgColor;

@property (nonatomic,copy) UIColor * titleColor;
@property (nonatomic,copy) UIColor * messageColor;

@property (nonatomic,copy) UIFont * titleFont;
@property (nonatomic,copy) UIFont * messageFont;

// default 280, if 0 don't add width constraint,
@property (nonatomic, assign) CGFloat alertViewWidth;

// contentView space custom
@property (nonatomic, assign) CGFloat contentViewSpace;

// textLabel custom
@property (nonatomic, assign) CGFloat textLabelSpace;
@property (nonatomic, assign) CGFloat textLabelContentViewEdge;

// button custom
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonSpace;
@property (nonatomic, assign) CGFloat buttonContentViewEdge;
@property (nonatomic, assign) CGFloat buttonContentViewTop;
@property (nonatomic, assign) CGFloat buttonCornerRadius;
@property (nonatomic, copy) UIFont *buttonFont;

@property (nonatomic, copy) UIColor *buttonDefaultTitleColor;
@property (nonatomic, copy) UIColor *buttonCancelTitleColor;
@property (nonatomic, copy) UIColor *buttonDestructiveTitleColor;

@property (nonatomic, copy) UIColor *buttonDefaultTitleColorForHigh;
@property (nonatomic, copy) UIColor *buttonCancelTitleColorForHigh;
@property (nonatomic, copy) UIColor *buttonDestructiveTitleColorForHigh;


@property (nonatomic, assign) CGFloat buttonDefaultBorderWidth;
@property (nonatomic, copy) UIColor *buttonDefaultBorderColor;

@property (nonatomic, assign) CGFloat buttonCancelBorderWidth;
@property (nonatomic, copy) UIColor *buttonCancelBorderColor;

@property (nonatomic, assign) CGFloat buttonDestructiveBorderWidth;
@property (nonatomic, copy) UIColor *buttonDestructiveBorderColor;


@property (nonatomic, copy) UIColor *buttonDefaultBgColor;
@property (nonatomic, copy) UIColor *buttonCancelBgColor;
@property (nonatomic, copy) UIColor *buttonDestructiveBgColor;

@property (nonatomic, copy) UIColor *buttonDefaultBgColorForHigh;
@property (nonatomic, copy) UIColor *buttonCancelBgColorForHigh;
@property (nonatomic, copy) UIColor *buttonDestructiveBgColorForHigh;

// textField custom
@property (nonatomic, assign) CGFloat textFieldCornerRadius;
@property (nonatomic, copy) UIColor *textFieldBorderColor;
@property (nonatomic, copy) UIColor *textFieldBackgroudColor;
@property (nonatomic, copy) UIFont *textFieldFont;
@property (nonatomic, assign) CGFloat textFieldHeight;
@property (nonatomic, assign) CGFloat textFieldEdge;
@property (nonatomic, assign) CGFloat textFieldBorderWidth;
@property (nonatomic, assign) CGFloat textFieldContentViewEdge;

@property (nonatomic, assign) BOOL clickedAutoHide; // default true

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;

- (void)addAction:(LMAlertAction *)action;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

@end

NS_ASSUME_NONNULL_END
