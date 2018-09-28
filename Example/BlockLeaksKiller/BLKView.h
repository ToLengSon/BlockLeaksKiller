//
//  BLKView.h
//  BlockLeaksKiller_Example
//
//  Created by wsong on 2018/9/28.
//  Copyright © 2018 wsong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLKView : UIView

@property (nonatomic, copy) void (^block)(void);

@end

NS_ASSUME_NONNULL_END
