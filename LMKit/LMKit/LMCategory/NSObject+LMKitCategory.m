//
//  NSObject+LMKitCategory.m
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "NSObject+LMKitCategory.h"

@implementation NSObject (LMKitCategory)

- (void)lm_CustomperformSelector:(SEL)selector {
    
    if (selector == NULL) {
        return;
    }
    
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
    
    
}

+ (NSString*)lm_ClassName {
    return NSStringFromClass([self class]);
}

@end
