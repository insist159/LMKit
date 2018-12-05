//
//  NSObject+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LMKitCategory)

- (void)lm_CustomperformSelector:(SEL)selector;

+ (NSString*)lm_ClassName;

@end
