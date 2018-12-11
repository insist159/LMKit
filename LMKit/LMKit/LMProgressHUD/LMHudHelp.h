//
//  LMHudHelp.h
//  LMKit
//
//  Created by 王迅 on 2018/12/6.
//  Copyright © 2018 wx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMProgressHUD.h"
#import "DGActivityIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMHudHelp : NSObject

@property (nonatomic,strong) UIColor * backgroundColor;
@property (nonatomic,assign) UIColor * tintColor;
@property (nonatomic,assign) NSTimeInterval delay;
@property (nonatomic,assign) CGSize minSize;
@property (nonatomic,copy) NSString * defaultLoadingString;
@property (nonatomic,assign) DGActivityIndicatorAnimationType customIndicatorType;
+ (LMHudHelp *)shared;

+ (void)hide;
+ (void)hideForView:(UIView*)view;

+ (void)hudShowLoading:(UIView*)view text:(NSString*)text;
+ (void)hudShowLoadingCustom:(UIView*)view text:(NSString*)text;
+ (void)hudShowLoadingWithText:(NSString*)text;
+ (void)hudShowLoadingCustomWithText:(NSString*)text;

+ (void)hudShowText:(NSString*)text;
+ (void)hudShowText:(NSString*)text isBottom:(BOOL)isBottom;
+ (void)hudShowText:(UIView*)view text:(NSString*)text;
+ (void)hudShowText:(UIView*)view text:(NSString*)text isBottom:(BOOL)isBottom;
@end

NS_ASSUME_NONNULL_END
