//
//  NSObject+BLKCoreExtension.m
//  Pods
//
//  Created by wsong on 2018/9/28.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import "MLeakedObjectProxy.h"
#import "MLeaksMessenger.h"

static BOOL _isOpenLeaksAlert = YES;

@implementation NSObject (BLKCoreExtension)

/** 是否打开内存泄露弹窗提示，默认为YES，可设置NO关闭 */
+ (void)blk_openLeaksAlert:(BOOL)isOpenLeaksAlert {
    _isOpenLeaksAlert = isOpenLeaksAlert;
}

struct BLKBlockImpl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

static NSString *blk_debugDescription(id obj, SEL sel) {
    struct BLKBlockImpl *block = (__bridge struct BLKBlockImpl *)(obj);
    Dl_info info;
    dladdr(block->FuncPtr, &info);
    NSLog(@"泄露对象所在的block定义处：%s", info.dli_sname);
    return ((NSString *(*)(id, SEL))class_getMethodImplementation(class_getSuperclass(NSClassFromString(@"NSBlock")),
                                                                  sel))(obj, sel);
}

static void blk_addLeakedObject(id obj, SEL sel, id parameter) {
    ((void *(*)(id, SEL, id))class_getMethodImplementation(objc_getMetaClass("MLeakedObjectProxy"), NSSelectorFromString(@"blk_addLeakedObject:")))(obj, NSSelectorFromString(@"blk_addLeakedObject:"), parameter);
    NSLog(@"内存泄漏对象地址 - %p", parameter);
}

static void alert(id obj, SEL sel, NSString *title, NSString *message, id delegate, NSString *additionalButtonTitle) {
    if (!_isOpenLeaksAlert) {
        return;
    }
    ((void *(*)(id, SEL,  NSString *, NSString *, id, NSString *))class_getMethodImplementation(objc_getMetaClass("MLeaksMessenger"), NSSelectorFromString(@"blk_alertWithTitle:message:delegate:additionalButtonTitle:")))(obj, NSSelectorFromString(@"blk_alertWithTitle:message:delegate:additionalButtonTitle:"), title, message, delegate, nil);
}

+ (void)load {
    
    Class blockClass = NSClassFromString(@"NSBlock");
    
    class_addMethod(blockClass,
                    @selector(debugDescription),
                    (IMP)blk_debugDescription,
                    method_getTypeEncoding(class_getInstanceMethod(blockClass, @selector(debugDescription))));
    
    Class leakedProxyMetaClass = objc_getMetaClass("MLeakedObjectProxy");
    Class leakedProxyClass = [MLeakedObjectProxy class];
    SEL addLeakedObjectSelector = @selector(addLeakedObject:);
    
    class_addMethod(leakedProxyMetaClass,
                    NSSelectorFromString(@"blk_addLeakedObject:"),
                    (IMP)blk_addLeakedObject,
                    method_getTypeEncoding(class_getClassMethod(leakedProxyMetaClass, addLeakedObjectSelector)));
    
    method_exchangeImplementations(class_getClassMethod(leakedProxyClass, addLeakedObjectSelector),
                                   class_getClassMethod(leakedProxyClass, NSSelectorFromString(@"blk_addLeakedObject:")));
    
    Class leaksMessengerMetaClass = objc_getMetaClass("MLeaksMessenger");
    Class leaksMessengerClass = [MLeaksMessenger class];
    SEL alertWithTitleSelector = @selector(alertWithTitle:message:delegate:additionalButtonTitle:);
    
    class_addMethod(leaksMessengerMetaClass,
                     NSSelectorFromString(@"blk_alertWithTitle:message:delegate:additionalButtonTitle:"),
                     (IMP)alert,
                     method_getTypeEncoding(class_getClassMethod(leaksMessengerMetaClass, alertWithTitleSelector)));
    
    method_exchangeImplementations(class_getClassMethod(leaksMessengerClass, alertWithTitleSelector),
                                   class_getClassMethod(leaksMessengerClass, NSSelectorFromString(@"blk_alertWithTitle:message:delegate:additionalButtonTitle:")));
}

@end
