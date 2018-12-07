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
        self.backgroundColor = [UIColor blackColor];
        self.tintColor = [UIColor whiteColor];
        self.delay = 2.f;
    }
    return self;
}

+ (LMProgressHUD *)hudForDefault:(UIView*)view {
    
    LMProgressHUD * hud = [LMProgressHUD HUDForView:view];
    if (!hud) {
        hud = [LMProgressHUD showHUDAddedTo:view animated:true];
    }
    
    return hud;
}

+ (void)hudShowLoading:(UIView*)view text:(NSString*)text {
    
    LMProgressHUD * hud = [LMHudHelp hudForDefault:view];
    hud.
    hud.label.text = text;
    
}


@end
