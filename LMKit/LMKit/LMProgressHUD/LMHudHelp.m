//
//  LMHudHelp.m
//  LMKit
//
//  Created by 王迅 on 2018/12/6.
//  Copyright © 2018 wx. All rights reserved.
//

#import "LMHudHelp.h"

@implementation LMHudHelp

+ (LMHudHelp *)shared {
    static LMHudHelp *shared = nil;
    static dispatch_once_t onceToken; 
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if(self=[super init]){
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.tintColor = [UIColor whiteColor];
        self.customIndicatorType = DGActivityIndicatorAnimationTypeCookieTerminator;
        self.delay = 2.f;
        self.minSize = CGSizeMake(120, 120);
   
    }
    return self;
}

+ (LMProgressHUD *)hudForDefault:(UIView*)view {
    
    LMProgressHUD * hud = [LMProgressHUD HUDForView:view];
    if (!hud) {
        hud = [LMProgressHUD showHUDAddedTo:view animated:true];
        hud.bezelView.color = [LMHudHelp shared].backgroundColor;
        hud.contentColor = [LMHudHelp shared].tintColor;
        hud.minSize = [LMHudHelp shared].minSize;
    }
    
    return hud;
}

+ (void)hide {
    [LMProgressHUD hideHUDForView:[LMHudHelp hudWidow] animated:true];
}

+ (void)hideForView:(UIView*)view {
    [LMProgressHUD hideHUDForView:view animated:true];
}

+ (UIView*)hudWidow {
    UIView * windowView;
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            windowView = window;
            break;
        }
    }
    
    if (windowView) {
        return windowView;
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

+ (void)hudShowLoading:(UIView*)view text:(NSString*)text {
    LMProgressHUD * hud = [LMHudHelp hudForDefault:view];
    hud.mode = LMProgressHUDModeIndeterminate;
    hud.label.text = text ? text : [LMHudHelp shared].defaultLoadingString;
}

+ (void)hudShowLoadingCustom:(UIView*)view text:(NSString*)text {
    LMProgressHUD * hud = [LMHudHelp hudForDefault:view];
    hud.mode = LMProgressHUDModeCustomView;
    DGActivityIndicatorView * customView = [[DGActivityIndicatorView alloc]initWithType:[LMHudHelp shared].customIndicatorType tintColor:[LMHudHelp shared].tintColor size:37];
    hud.customView = customView;
    [customView startAnimating];
    hud.square = true;
    hud.label.text = text ? text : [LMHudHelp shared].defaultLoadingString;
}

+ (void)hudShowLoadingWithText:(NSString*)text {
    [LMHudHelp hudShowLoading:[LMHudHelp hudWidow] text:text];
}

+ (void)hudShowLoadingCustomWithText:(NSString*)text {
    [LMHudHelp hudShowLoadingCustom:[LMHudHelp hudWidow] text:text];
}

+ (void)hudShowText:(NSString*)text {
    [LMHudHelp hudShowText:text isBottom:false];
}

+ (void)hudShowText:(NSString*)text isBottom:(BOOL)isBottom {
    [LMHudHelp hudShowText:[LMHudHelp hudWidow] text:text isBottom:false];
}

+ (void)hudShowText:(UIView*)view text:(NSString*)text {
    
    [LMHudHelp hudShowText:view text:text isBottom:false];
}

+ (void)hudShowText:(UIView*)view text:(NSString*)text isBottom:(BOOL)isBottom {
    LMProgressHUD * hud = [LMHudHelp hudForDefault:view];
    hud.mode = LMProgressHUDModeText;
    hud.label.text = nil;
    hud.detailsLabel.text = text;
    hud.minSize = CGSizeZero;
    if (isBottom) {
        hud.offset = CGPointMake(0.f, LMProgressMaxOffset);
    }
    [hud hideAnimated:true afterDelay:[LMHudHelp shared].delay];
}

@end
