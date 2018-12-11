//
//  ViewController.m
//  LMKit
//
//  Created by 王迅 on 2018/12/5.
//  Copyright © 2018 wx. All rights reserved.
//

#import "ViewController.h"
#import "LMKit.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showCustomLoading:(id)sender {
    [LMHudHelp hudShowLoadingCustom:self.view text:@"hahaha"];
    
    
}

- (IBAction)showLoadingView:(id)sender {
    [LMHudHelp hudShowLoading:self.view text:@"text"];
}
- (IBAction)showText:(id)sender {
    [LMHudHelp hudShowText:@"asdasdasd2312312312adsdasdasdaczxczxczxcasd"];
}
- (IBAction)showloadingtext:(id)sender {
    [LMHudHelp hudShowLoadingWithText:@"loading..."];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [LMHudHelp hudShowText:@"success"];
        });
    });
    
}

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

@end
