//
//  UIWindow+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (LMKitCategory)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*) lm_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
+ (UIViewController *)lm_getCurrentVC;

- (UIViewController*)lm_currentViewController;

+ (UIViewController*)lm_topViewController;
@end
