//
//  LMTextView.h
//  AudioWork
//
//  Created by lm on 2018/3/10.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMTextView;

@interface LMTextView : UITextView

@property (nonatomic, copy) NSString * placeHolder;

@property (nonatomic, strong) UIColor * placeHolderTextColor;

- (NSUInteger)numberOfLinesOfText;
@end
