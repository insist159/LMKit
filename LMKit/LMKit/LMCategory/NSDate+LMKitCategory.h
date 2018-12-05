//
//  NSDate+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LMKitCategory)

- (BOOL)lm_isToday;

- (BOOL)lm_isYesterday;

- (NSString *)lm_shortTimeTextOfDate;

- (NSString *)lm_timeTextOfDate;

+ (NSDate*)lm_dateNow;

+ (NSString *)lm_getCurrentStringTime;

+ (NSInteger)lm_dateForTimeInterval;

@end
