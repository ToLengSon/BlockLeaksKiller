//
//  NSObject+BLKCoreExtension.m
//  Pods
//
//  Created by wsong on 2018/9/28.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MLeakedObjectProxy.h"

@implementation NSObject (BLKCoreExtension)

struct BLKBlockImpl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

static NSString *blk_description(id obj, SEL sel) {
    struct BLKBlockImpl *block = (__bridge struct BLKBlockImpl *)(obj);
    NSLog(@"image lookup --address %p", block->FuncPtr);
    return ((NSString *(*)(id, SEL))class_getMethodImplementation(class_getSuperclass(NSClassFromString(@"NSBlock")),
                                                                  sel))(obj, sel);
}

static void blk_addLeakedObject(id obj, SEL sel, id parameter) {
    ((void *(*)(id, SEL, id))class_getMethodImplementation(objc_getMetaClass("MLeakedObjectProxy"), NSSelectorFromString(@"blk_addLeakedObject:")))(obj, NSSelectorFromString(@"blk_addLeakedObject:"), parameter);
    NSLog(@"内存泄漏对象地址 - %p", parameter);
}

+ (void)load {
    
    Class blockClass = NSClassFromString(@"NSBlock");
    
    class_addMethod(blockClass,
                    @selector(description),
                    (IMP)blk_description,
                    method_getTypeEncoding(class_getInstanceMethod(blockClass, @selector(description))));
    
    Class leakedProxyMetaClass = objc_getMetaClass("MLeakedObjectProxy");
    Class leakedProxyClass = [MLeakedObjectProxy class];
    SEL selector = @selector(addLeakedObject:);
    
    class_addMethod(leakedProxyMetaClass,
                    NSSelectorFromString(@"blk_addLeakedObject:"),
                    (IMP)blk_addLeakedObject,
                    method_getTypeEncoding(class_getClassMethod(leakedProxyMetaClass, selector)));
    
    method_exchangeImplementations(class_getClassMethod(leakedProxyClass, selector),
                                   class_getClassMethod(leakedProxyClass, NSSelectorFromString(@"blk_addLeakedObject:")));
}

@end
