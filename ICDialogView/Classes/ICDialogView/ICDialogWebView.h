//
//  ICDialogWebView.h
//  CLKit_Example
//
//  Created by 秦传龙 on 2020/7/24.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICDialogWebView : WKWebView

- (void)loadWebviewWithURL:(NSURL *)url;
- (void)loadWebviewWithHtmlStr:(NSString *)htmlStr;

@end

NS_ASSUME_NONNULL_END
