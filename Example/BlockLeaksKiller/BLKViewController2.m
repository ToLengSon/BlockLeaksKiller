//
//  BLKViewController2.m
//  BlockLeaksKiller_Example
//
//  Created by wsong on 2018/9/28.
//  Copyright © 2018 wsong. All rights reserved.
//

#import "BLKViewController2.h"
#import "BLKView.h"

@interface BLKViewController2 ()

@end

@implementation BLKViewController2

- (void)viewDidLoad {
    
    BLKView *view = [[BLKView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    view.backgroundColor = [UIColor greenColor];
    view.block = ^{
        NSLog(@"%@", self);
    };
    [self.view addSubview:view];
}

- (IBAction)onClick:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
