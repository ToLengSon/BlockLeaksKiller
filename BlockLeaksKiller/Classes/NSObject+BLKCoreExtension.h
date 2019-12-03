//
//  NSObject+BLKCoreExtension.h
//  BlockLeaksKiller
//
//  Created by wsong on 2019/12/3.
//


#import <Foundation/Foundation.h>

@interface NSObject (BLKCoreExtension)

/** 是否打开内存泄露弹窗提示，默认为YES，可设置NO关闭 */
+ (void)blk_openLeaksAlert:(BOOL)isOpenLeaksAlert;

@end
