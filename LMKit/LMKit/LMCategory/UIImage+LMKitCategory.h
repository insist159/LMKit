//
//  UIImage+LMKitCategory.h
//  LMKit
//
//  Created by lm on 2018/3/6.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LMKitCategory)

+ (UIImage *_Nullable)lm_imageWithColor:(UIColor *_Nullable)color;
+ (UIImage *_Nullable)lm_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size;

- (UIImage *) lm_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) lm_imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)lm_imageByBlurRadius:(CGFloat)blurRadius
                        tintColor:(UIColor *)tintColor
                         tintMode:(CGBlendMode)tintBlendMode
                       saturation:(CGFloat)saturation
                        maskImage:(UIImage *)maskImage;
@end

NS_ASSUME_NONNULL_END
