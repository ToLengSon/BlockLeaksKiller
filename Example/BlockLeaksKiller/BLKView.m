//
//  BLKView.m
//  BlockLeaksKiller_Example
//
//  Created by wsong on 2018/9/28.
//  Copyright © 2018 wsong. All rights reserved.
//

#import "BLKView.h"

@implementation BLKView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.block) {
        self.block();
    }
}

@end
