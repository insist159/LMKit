//
//  LMAlertViewConfig.h
//  LMKit
//
//  Created by lm on 2018/3/1.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LMAlertViewConfig : NSObject

+ (LMAlertViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat contentViewCornerRadius;
@property (nonatomic,strong) UIColor *contentViewBgColor;

@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIColor * messageColor;

@property (nonatomic,strong) UIFont * titleFont;
@property (nonatomic,strong) UIFont * messageFont;

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
@property (nonatomic, strong) UIFont *buttonFont;

@property (nonatomic, strong) UIColor *buttonDefaultTitleColor;
@property (nonatomic, strong) UIColor *buttonCancelTitleColor;
@property (nonatomic, strong) UIColor *buttonDestructiveTitleColor;

@property (nonatomic, strong) UIColor *buttonDefaultTitleColorForHigh;
@property (nonatomic, strong) UIColor *buttonCancelTitleColorForHigh;
@property (nonatomic, strong) UIColor *buttonDestructiveTitleColorForHigh;

@property (nonatomic, assign) CGFloat buttonDefaultBorderWidth;
@property (nonatomic, strong) UIColor *buttonDefaultBorderColor;

@property (nonatomic, assign) CGFloat buttonCancelBorderWidth;
@property (nonatomic, strong) UIColor *buttonCancelBorderColor;

@property (nonatomic, assign) CGFloat buttonDestructiveBorderWidth;
@property (nonatomic, strong) UIColor *buttonDestructiveBorderColor;


@property (nonatomic, strong) UIColor *buttonDefaultBgColor;
@property (nonatomic, strong) UIColor *buttonCancelBgColor;
@property (nonatomic, strong) UIColor *buttonDestructiveBgColor;

@property (nonatomic, strong) UIColor *buttonDefaultBgColorForHigh;
@property (nonatomic, strong) UIColor *buttonCancelBgColorForHigh;
@property (nonatomic, strong) UIColor *buttonDestructiveBgColorForHigh;

// textField custom
@property (nonatomic, assign) CGFloat textFieldCornerRadius;
@property (nonatomic, strong) UIColor *textFieldBorderColor;
@property (nonatomic, strong) UIColor *textFieldBackgroudColor;
@property (nonatomic, strong) UIFont *textFieldFont;
@property (nonatomic, assign) CGFloat textFieldHeight;
@property (nonatomic, assign) CGFloat textFieldEdge;
@property (nonatomic, assign) CGFloat textFieldBorderWidth;
@property (nonatomic, assign) CGFloat textFieldContentViewEdge;

// alertcontroller custom
@property (nonatomic, strong) UIColor *alertControllerBackgroundColor;
@property (nonatomic, assign) CGFloat alertStyleEdging;
@property (nonatomic, assign) CGFloat actionSheetStyleEdging;

@end
