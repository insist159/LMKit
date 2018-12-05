//
//  UIColor+LMKitCategory.h
//  LMKit
//
//  Created by lm on 2018/3/6.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LMKitCategory)

+ (nullable UIColor *)lm_colorWithHexString:(NSString *_Nullable)hexStr;

@end

NS_ASSUME_NONNULL_END
