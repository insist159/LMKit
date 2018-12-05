//
//  UILabel+LMKitCategory.h
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LMKitCategory)
- (CGSize)lm_suggestedSizeForWidth:(CGFloat)width;
+ (CGSize)lm_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;
- (CGSize)lm_suggestSizeForString:(NSString *)string width:(CGFloat)width;
@end
