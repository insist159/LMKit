//
//  UINavigationController+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (LMKitCategory)

/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)lm_findViewController:(NSString*)className;
/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)lm_isOnlyContainRootViewController;
/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)lm_rootViewController;
/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)lm_popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)lm_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

@end
