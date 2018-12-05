//
//  LMTextField.m
//  InsApp
//
//  Created by wangxun on 2018/9/1.
//  Copyright © 2018年 BMWBMW. All rights reserved.
//

#import "LMTextField.h"

@implementation LMTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}


@end
