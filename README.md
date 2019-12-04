# BlockLeaksKiller

[![CI Status](https://img.shields.io/travis/wsong/BlockLeaksKiller.svg?style=flat)](https://travis-ci.org/wsong/BlockLeaksKiller)
[![Version](https://img.shields.io/cocoapods/v/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)
[![License](https://img.shields.io/cocoapods/l/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)
[![Platform](https://img.shields.io/cocoapods/p/BlockLeaksKiller.svg?style=flat)](https://cocoapods.org/pods/BlockLeaksKiller)

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

iOS 13默认实现了NSBlock的debugDescription方法，因此保持系统默认的

![](https://tva1.sinaimg.cn/large/006tNbRwly1g9kf1gcrzjj30vn06517e.jpg)

低版本中，NSBlock没有实现debugDescription方法，因此该工具实现了该方法

![](https://tva1.sinaimg.cn/large/006tNbRwly1g9kf5dh63fj31j603g0tz.jpg)

自行跳转至代码处修复

## UpdateLog

- 0.0.1版本打印block时，输出的是lldb命令，需要用户复制lldb命令，因此该版本减少这一步，直接打印block定义位置

- 新增NSObject+BLKCoreExtension.h文件，提供方法控制开启关闭内存泄露弹窗提示

## Feature

之后要做的，是减少开发者的操作步骤：去除用户查看内存图，内存泄漏直接弹窗提示，点击跳转至泄漏的代码位置

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
