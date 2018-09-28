//
//  BLKViewController2.m
//  BlockLeaksKiller_Example
//
//  Created by wsong on 2018/9/28.
//  Copyright © 2018 wsong. All rights reserved.
//

#import "BLKViewController2.h"

@interface BLKViewController2 ()

@property (nonatomic, copy) void (^block)(void);

@end

@implementation BLKViewController2

- (void)viewDidLoad {
    
    self.block = ^{
        [super viewDidLoad];
    };
    self.block();
}

- (IBAction)onClick:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
