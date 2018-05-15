# tryon-module-ios

[![CI Status](http://img.shields.io/travis/supermariobean/tryon-module-ios.svg?style=flat)](https://travis-ci.org/supermariobean/tryon-module-ios)
[![Version](https://img.shields.io/cocoapods/v/tryon-module-ios.svg?style=flat)](http://cocoapods.org/pods/tryon-module-ios)
[![License](https://img.shields.io/cocoapods/l/tryon-module-ios.svg?style=flat)](http://cocoapods.org/pods/tryon-module-ios)
[![Platform](https://img.shields.io/cocoapods/p/tryon-module-ios.svg?style=flat)](http://cocoapods.org/pods/tryon-module-ios)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

tryon-module-ios is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'tryon-module-ios'
```

## 说明

由于美国团队给到这边的 `MFESephora.framework` 分 `dev` 和 `prod` 版本， 为了解决主 APP 自动关联合适的 framework。 这里提供了两个不同的 `podsepc` 文件:

    tryon-module-ios.podsepc        // 供 Release 包使用
    tryon-module-ios-debug.podspec  // 供 Debug 包使用
    
两个不同的 `podspec` 文件内容基本一致， 只是在获取匹配 frameowork 文件资源的时候会匹配到不同的目录:

    tryon-module-ios/Frameworks/prod/MFESephoraKit.framework
    tryon-module-ios/Assets/prod/MFESephoraBundle.bundle

    tryon-module-ios/Frameworks/dev/MFESephoraKit.framework
    tryon-module-ios/Assets/dev/MFESephoraBundle.bundle

所以如果要更新库， ***一定要到相应文件目录下删除旧版本，复制新版***

整个模块(Module)对外暴露的服务(Service)只有一个 `SEPTryonServiceProtocol` 比较简单

需要重点说明的接口或者说流程应该是 `-(AnyPromise *)syncData` 方法:

该方法目前会在应用启动时间中调用， 调用后能会做以下逻辑:

1. 判断当前应用程序是否是当前版本的第一次启动， 如果是， 移除本地缓存的虚拟试装 skuId 集合; 如果不是， 什么都不做
2. 同步 SDK 中的本地 skuId 数据
    1. 首先判断本地沙盒中是否有本地的缓存数据， 如果有， 什么都不做; 如果没有， 从 SDK 中获取 .csv 文件然后获取 skuId 文件合集， 并保存在本地沙盒路径
3. 同步 远程服务器中的 skuID 数据, 获取接口中的 .csv 文件格式的内容， 保存 skuId 文件合集， 并覆盖之前的本地沙盒路径

+ 如果程序内存紧张， 释放内存中的 skuId 合集对象
+ 每次需要使用 skuId 合集时， 如果内存没有， 则从本地沙盒读取

### 注意

因为本项目使用了 `git-lfs` 工具管理大文件， 而其中的 `framework` 中的 `.a` 文件都在 100MB 以上， 所以需要注意新添加的文件 `git-lfs` .gitattributes 文件中的跟踪列表， 如果已经跟踪， git 会自动上传新加入的 framework， 如果不在跟踪列表内， 则需要单独设置。

## Author

david.fu, david.fu@connext.com.cn

## License

tryon-module-ios is available under the MIT license. See the LICENSE file for more info.
