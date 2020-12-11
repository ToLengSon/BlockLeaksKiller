# BlockLeaksKiller

[![CI Status](https://img.shields.io/travis/wsong/BlockLeaksKiller.svg?style=flat)](https://travis-ci.org/wsong/BlockLeaksKiller)
[![Version](https://img.shields.io/cocoapods/v/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)
[![License](https://img.shields.io/cocoapods/l/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)
[![Platform](https://img.shields.io/cocoapods/p/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)

# 新增两个宏，从编译期间避免block的循环引用

```objective-c
#define ZbWeakBlock(obj, block) ({__weak typeof(obj) weak##obj = obj; __weak typeof(weak##obj) obj = weak##obj; block;})

#define ZbWeakSelfBlock(block) ZbWeakBlock(self, block)

self.block = ZbWeakSelfBlock(^{
    NSLog(@"访问self也不会循环引用：%@ - %@", self, weakself);
});
self.block();
```

## Example

以demo为例：

当发生内存泄漏时，会有弹窗提示

![](https://tva1.sinaimg.cn/large/006tNbRwly1g9keyfk49cj3090056gtn.jpg)

这时请看控制台的输出：

![](https://ws1.sinaimg.cn/large/006tNc79gy1fvp3huyhznj30oq03ot9j.jpg)

复制内存泄漏对象地址：

打开Xcode内存图功能：

![](https://ws1.sinaimg.cn/large/006tNc79gy1fvp3jqr2utj309o0140ss.jpg)

粘贴内存泄漏对象地址进行查找过滤：

![](https://ws1.sinaimg.cn/large/006tNc79gy1fvp3l1iqi4j307i066weu.jpg)

鼠标右键箭头所指向的block->点击Print Description：

![](https://ws2.sinaimg.cn/large/006tNc79gy1fvp3mn7m38j30fh0atmxw.jpg)

查看控制台的输出：

![](https://ws1.sinaimg.cn/large/006tNc79gy1fvp3ohoyf8j30mc01djrn.jpg)

复制红线命令，粘贴至lldb：

![](https://ws4.sinaimg.cn/large/006tNc79gy1fvp3pw65j6j30ov01s74o.jpg)

红框部分就是block导致循环引用的代码定义处，请自行跳转代码进行修复.

## Requirements

## Installation

BlockLeaksKiller is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BlockLeaksKiller'
```

## Author

wsong, 835151791@qq.com

## License

BlockLeaksKiller is available under the MIT license. See the LICENSE file for more info.
