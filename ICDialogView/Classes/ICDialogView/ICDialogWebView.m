//
//  ICDialogWebView.m
//  CLKit_Example
//
//  Created by 秦传龙 on 2020/7/24.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import "ICDialogWebView.h"


@interface ICDialogWebView ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *emptyView;


@end


@implementation ICDialogWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navigationDelegate = self;
        self.UIDelegate = self;
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
//        [self addSubview:self.progressView];
    }
    return self;
}

- (WKWebViewConfiguration *)configuration {
    return [[WKWebViewConfiguration alloc] init];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self.superview addSubview:self.progressView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressView.frame = CGRectMake(0, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 1);
}


#pragma mark -- lazy
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [UIProgressView new];
        _progressView.progress = 0.1;
        _progressView.progressTintColor = [UIColor colorWithRed:247/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        _progressView.trackTintColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _progressView;
}


#pragma mark --- pubilc method

- (void)loadWebviewWithURL:(NSURL *)url {
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadWebviewWithHtmlStr:(NSString *)htmlStr {
    [self loadHTMLString:htmlStr baseURL:nil];
}


#pragma mark -- delegate

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [change[@"new"] floatValue];
        [self.progressView setProgress:progress animated:YES];
        self.progressView.hidden = progress >= 1;
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
