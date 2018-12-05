//
//  UILabel+LMKitCategory.m
//  AudioWork
//
//  Created by lm on 2018/3/9.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "UILabel+LMKitCategory.h"

@implementation UILabel (LMKitCategory)

- (CGSize)lm_suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [UILabel lm_suggestSizeForAttributedString:self.attributedText width:width];
    
    return [self lm_suggestSizeForString:self.text width:width];
}

+ (CGSize)lm_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)lm_suggestSizeForString:(NSString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [UILabel lm_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
