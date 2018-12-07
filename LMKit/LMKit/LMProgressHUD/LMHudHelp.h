//
//  LMHudHelp.h
//  LMKit
//
//  Created by 王迅 on 2018/12/6.
//  Copyright © 2018 wx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN

@interface LMHudHelp : NSObject

@property (nonatomic,strong) UIColor * backgroundColor;
@property (nonatomic,assign) UIColor * tintColor;
@property (nonatomic,assign) NSTimeInterval delay;

+ (LMHudHelp *)shared;

@end

NS_ASSUME_NONNULL_END
