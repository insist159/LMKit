//
//  LMAlertViewConfig.m
//  LMKit
//
//  Created by lm on 2018/3/1.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "LMAlertViewConfig.h"
#import "LMKitMacro.h"
#import "LMKitCategory.h"



@implementation LMAlertViewConfig

+ (LMAlertViewConfig *)globalConfig
{
    static LMAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [LMAlertViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.contentViewCornerRadius = 5;
        self.contentViewBgColor = [UIColor whiteColor];
        
        self.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];;
        self.titleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        self.messageFont = [UIFont fontWithName:@"HelveticaNeue" size:15];
        self.messageColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        self.alertViewWidth = 280;
        self.contentViewSpace = 15;
        self.textLabelSpace = 6;
        self.textLabelContentViewEdge = 15;
        self.buttonHeight = 44;
        self.buttonSpace = 20;
        self.buttonContentViewEdge = 15;
        self.buttonContentViewTop = 15;
        self.buttonCornerRadius = 4.0;
        
        self.buttonDefaultBorderWidth = 0;
        self.buttonDefaultBorderColor = [UIColor clearColor];
        
        self.buttonCancelBorderWidth = 0;
        self.buttonCancelBorderColor = [UIColor clearColor];
        
        self.buttonDestructiveBorderWidth = 0;
        self.buttonDestructiveBorderColor = [UIColor clearColor];
        
        self.buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:14];
        
        self.buttonDefaultTitleColor = [UIColor whiteColor];
        self.buttonCancelTitleColor = [UIColor lightGrayColor];
        self.buttonDestructiveTitleColor = [UIColor whiteColor];
        
        self.buttonDefaultTitleColorForHigh = [UIColor whiteColor];
        self.buttonCancelTitleColorForHigh = [UIColor lightGrayColor];
        self.buttonDestructiveTitleColorForHigh = [UIColor whiteColor];
        
        self.buttonDefaultBgColor = LMColorHex(E93419);
        self.buttonCancelBgColor = [UIColor groupTableViewBackgroundColor];
        self.buttonDestructiveBgColor = LMColorHex(E93419);
        
        self.buttonDefaultBgColorForHigh = LMColorHex(A63415);
        self.buttonCancelBgColorForHigh = LMColorHex(EAEAEA);
        self.buttonDestructiveBgColorForHigh = LMColorHex(A63415);
        
        
        
        self.textFieldHeight = 44;
        self.textFieldEdge = 8;
        self.textFieldBorderWidth = 0.5;
        self.textFieldContentViewEdge = 15;
        self.textFieldCornerRadius = 4;
        self.textFieldBorderColor = [UIColor blackColor];
        self.textFieldBackgroudColor = LMColorHex(F0F0F0);
        self.textFieldFont = [UIFont systemFontOfSize:14];
        
        self.alertControllerBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.alertStyleEdging = 15;
        self.actionSheetStyleEdging = 0;
    }
    
    return self;
}

@end
