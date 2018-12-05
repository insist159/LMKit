//
//  UIResponder+LMKitCategory.m
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "UIResponder+LMKitCategory.h"

@implementation UIResponder (LMKitCategory)

- (void)lm_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] lm_routerEventWithName:eventName userInfo:userInfo];
}

@end
