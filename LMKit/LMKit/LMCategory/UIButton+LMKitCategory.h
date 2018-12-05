//
//  UIButton+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LMButtonEdgeInsetsStyle) {
    LMButtonEdgeInsetsStyleTop, // image在上，label在下
    LMButtonEdgeInsetsStyleLeft, // image在左，label在右
    LMButtonEdgeInsetsStyleBottom, // image在下，label在上
    LMButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (LMKitCategory)

/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)lm_startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

//按钮的动画
- (void)lm_popOutsideWithDuration:(NSTimeInterval)duration;
- (void)lm_popInsideWithDuration:(NSTimeInterval)duration;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)lm_layoutButtonWithEdgeInsetsStyle:(LMButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
