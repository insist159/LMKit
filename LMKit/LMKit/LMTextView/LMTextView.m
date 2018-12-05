//
//  LMTextView.m
//  AudioWork
//
//  Created by lm on 2018/3/10.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "LMTextView.h"
#import "LMKitMacro.h"
#import "LMUtilsMacros.h"
#import "LMKitCategory.h"
@implementation LMTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = SYSTEMFONT(15);
        self.textColor = LMColorHex(4A4A4A);
        self.contentMode = UIViewContentModeRedraw;
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
        
        _placeHolder = nil;
        _placeHolderTextColor = [UIColor lightGrayColor];
        
        [self _addTextViewNotificationObservers];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.font = SYSTEMFONT(15);;
        self.textColor = LMColorHex(4A4A4A);
        self.contentMode = UIViewContentModeRedraw;
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
    }
    _placeHolder = nil;
    _placeHolderTextColor = [UIColor lightGrayColor];
    
    [self _addTextViewNotificationObservers];
    
    return self;
}


- (void)dealloc
{
    [self _removeTextViewNotificationObservers];
}

- (void)deleteBackward
{
    [super deleteBackward];
}

#pragma mark -RFTextView 方法
- (NSUInteger)numberOfLinesOfText{
    return [LMTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)? 33:109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text{
    return (text.length / [LMTextView maxCharactersPerLine]) + 1;
}

#pragma mark -- Setters
- (void)setPlaceHolder:(NSString *)placeHolder
{
    if ([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    if ([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark -- UITextView overrides
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark -- Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if ([self.text length] == 0 && self.placeHolder) {
        [self.placeHolderTextColor set];
        [self.placeHolder drawInRect:CGRectInset(rect, 7.0f, 7.5f) withAttributes:[self _placeholderTextAttributes]];
    }
}

#pragma mark -- Notifications
- (void)_addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)_didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)_removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
    
}

- (NSDictionary *)_placeholderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    
    return @{ NSFontAttributeName : self.font,
              NSForegroundColorAttributeName : self.placeHolderTextColor,
              NSParagraphStyleAttributeName : paragraphStyle };
}


@end
