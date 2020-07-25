# ICDialogView

[![CI Status](https://img.shields.io/travis/LimMem/ICDialogView.svg?style=flat)](https://travis-ci.org/LimMem/ICDialogView)
[![Version](https://img.shields.io/cocoapods/v/ICDialogView.svg?style=flat)](https://cocoapods.org/pods/ICDialogView)
[![License](https://img.shields.io/cocoapods/l/ICDialogView.svg?style=flat)](https://cocoapods.org/pods/ICDialogView)
[![Platform](https://img.shields.io/cocoapods/p/ICDialogView.svg?style=flat)](https://cocoapods.org/pods/ICDialogView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ICDialogView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ICDialogView'
```

## Author

LimMem, qcl901028@gmail.com

## License

ICDialogView is available under the MIT license. See the LICENSE file for more info.

## 如何使用

```
 #import<ICDialogView/ICDialogView.h>
 
ICDialogView *dialogView = [ICDialogView dialogViewWithTitle:@"是否删除所有的搜索记录？" message:@"" preferredStyle:ICDialogViewStyleAlert];

[dialogView addAction: [ICDialogAction actionWithTitle:@"取消" style:ICDialogActionStyleCancel handler:nil]];

[dialogView addAction: [ICDialogAction actionWithTitle:@"确认" style:ICDialogActionStyleDefault handler:^(ICDialogAction * _Nonnull action) {

}]];
[dialogView showDialogViewToSuperView:self.view];


```