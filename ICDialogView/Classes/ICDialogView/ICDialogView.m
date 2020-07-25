//
//  ICDialogView.m
//  ICKit_Example
//
//  Created by 秦传龙 on 2020/7/23.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import "ICDialogView.h"
#import "ICDialogAction.h"
#import "ICDialogWebView.h"

static const CGFloat marginH = 40;

@interface ICDialogView ()

/*   初始化值   */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) ICDialogViewStyle style;
@property (nonatomic, strong) NSMutableArray<UIButton *> *actionList;
@property (nonatomic, strong) NSMutableArray<ICDialogAction *> *dialogActions;
@property (nonatomic, assign) CGFloat viewWidth;
// 自定义视图高度
@property (nonatomic, assign) CGFloat viewHeight;


/* 视图 */
@property (nonatomic, strong) UIView *bgView;  // 白色底边

@property (nonatomic, assign) BOOL isShow; // 是否展示

@property (nonatomic, strong) UILabel *titleLabel;  // header
@property (nonatomic, strong) UILabel *contentLabel; // 内容区域
@property (nonatomic, strong) ICDialogWebView *webView; // webview内容区域

@end



@implementation ICDialogView

#pragma mark --- life cycle

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(ICDialogViewStyle)preferredStyle
{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.style = preferredStyle;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
        [self addGestureRecognizer:tap];
        switch (preferredStyle) {
            case ICDialogViewStyleAlert:
                [self didInitialzeAlertView];
                break;
            case ICDialogViewStyleWebAlertView:
                [self didInitialzeWebAlertView];
                break;
            default:
                break;
        }
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayout];
}

- (void)tapHandle{}

#pragma mark --- 更新布局
- (void)updateLayout {
    switch (self.style) {
        case ICDialogViewStyleAlert:
            [self updateLayoutAlertView];
            break;
        case ICDialogViewStyleWebAlertView:
            [self updateLayoutWebAlertView];
            break;
        default:
            break;
    }
}

- (void)updateLayoutAlertView {
    if (!self.isShow) {
        return;
    }
    CGFloat spaceH = 20;
    CGFloat spaceV = 12;
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    CGFloat maxY = 0; // 修改控件尺寸，记得更新maxY
    if (self.title && self.title.length > 0) {
        NSString *message = (NSString *)self.message;
        if (!message || message.length == 0) {
            // 没有内容区域
            self.titleLabel.frame = CGRectMake(spaceH, 0, self.viewWidth - spaceH * 2, CGRectGetHeight(self.titleLabel.frame) + 2 * 32);
            self.contentLabel.frame = CGRectZero;
            maxY = CGRectGetMaxY(self.titleLabel.frame);
        } else {
            self.titleLabel.frame = CGRectMake(spaceH, 0, self.viewWidth - spaceH * 2, CGRectGetHeight(self.titleLabel.frame) + 2 * spaceV);
            self.contentLabel.frame = CGRectMake(spaceH, CGRectGetMaxY(self.titleLabel.frame) , self.viewWidth - spaceH * 2,[self getLabelHeight:self.contentLabel]);
            maxY = CGRectGetMaxY(self.contentLabel.frame);
        }
    } else {
        self.titleLabel.frame = CGRectZero;
        self.contentLabel.frame = CGRectMake(spaceH, 0, self.viewWidth - spaceH * 2,[self getLabelHeight:self.contentLabel] + 70);
        maxY = CGRectGetMaxY(self.contentLabel.frame);
    }
    
    if (self.message.length == 0 || self.title.length == 0  ) {
        spaceV = 0;
    }
    if (self.actionList.count == 1) {
        self.actionList[0].frame = CGRectMake(spaceH, maxY + spaceV, self.viewWidth - spaceH * 2, 36);
        maxY = CGRectGetMaxY(self.actionList[0].frame);
    } else if (self.actionList.count == 2) {
        CGFloat btnWidth = (self.viewWidth - spaceH * 2 - 10) / 2;
         self.actionList[0].frame = CGRectMake(spaceH, maxY + spaceV, btnWidth, 36);
        self.actionList[1].frame = CGRectMake(CGRectGetMaxX(self.actionList[0].frame) + 10, maxY + spaceV, btnWidth, 36);
        maxY = CGRectGetMaxY(self.actionList[0].frame);
    }
    
    spaceV = 12;

    CGRect frame = self.bgView.frame;
    frame.size.height = maxY + spaceV;
    frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
    self.bgView.frame = frame;
}

- (void)updateLayoutWebAlertView {
    if (!self.isShow) {
        return;
    }
    CGFloat spaceH = 20;
    CGFloat spaceV = 12;
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    CGFloat maxY = 0; // 修改控件尺寸，记得更新maxY
    if (self.title && self.title.length > 0) {
        self.titleLabel.frame = CGRectMake(spaceH, 0, self.viewWidth - spaceH * 2, CGRectGetHeight(self.titleLabel.frame) + 2 * spaceV);
    } else {
        self.titleLabel.frame = CGRectZero;
    }
    
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.viewWidth , self.viewWidth + 60);
    maxY = CGRectGetMaxY(self.webView.frame);
    
    if (self.actionList.count == 1) {
        self.actionList[0].frame = CGRectMake(spaceH, maxY + 12, self.viewWidth - spaceH * 2, 36);
        maxY = CGRectGetMaxY(self.actionList[0].frame);
    } else if (self.actionList.count == 2) {
        CGFloat btnWidth = (self.viewWidth - spaceH * 2 - 10) / 2;
        self.actionList[0].frame = CGRectMake(spaceH, maxY + 12, btnWidth, 36);
        self.actionList[1].frame = CGRectMake(CGRectGetMaxX(self.actionList[0].frame) + 10, maxY + 12, btnWidth, 36);
        maxY = CGRectGetMaxY(self.actionList[0].frame);
    }
    
    CGRect frame = self.bgView.frame;
    frame.size.height = maxY + spaceV;
    frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
    self.bgView.frame = frame;
}

#pragma mark --- 创建视图

- (void)didInitialze {
    self.viewWidth = [UIScreen mainScreen].bounds.size.width - marginH * 2;
    self.viewHeight = [UIScreen mainScreen].bounds.size.width / 2.0f;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    [self beginBgViewRect];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
}

- (void)didInitialzeWebAlertView {
    [self didInitialze];
    [self.bgView addSubview:self.webView];
}

- (void)didInitialzeActionSheetView {
    [self didInitialze];
}

- (void)didInitialzeAlertView {
    [self didInitialze];
    [self.bgView addSubview:self.contentLabel];
}

- (void)beginBgViewRect {
    self.bgView.center = self.center;
    self.bgView.alpha = 0;
    self.alpha = 0;
    self.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
}

- (void)endBgViewRect {
    self.bgView.alpha = 1;
    self.alpha = 1;
    self.bgView.transform = CGAffineTransformIdentity;
}

- (void)showAnimation {
    if (self.isShow) {
        return;
    }
    self.isShow = YES;
    [UIView animateWithDuration:0.1 animations:^{
        [self endBgViewRect];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideAnimation {
    if (!self.isShow) {
        return;
    }
    self.isShow = NO;

    [UIView animateWithDuration:0.1 animations:^{
        [self beginBgViewRect];
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}

- (CGFloat)getLabelHeight:(UILabel *)label {
    [label sizeToFit];
    CGFloat height = CGRectGetHeight(label.frame) > self.viewWidth ? self.viewWidth : CGRectGetHeight(label.frame);
    return height;
}

- (void)addBtnWithAction:(ICDialogAction *)action {
    [self.dialogActions addObject:action];
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:action.title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 18;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.tag = self.dialogActions.count;
    [btn addTarget:self action:@selector(actionHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    switch (action.style) {
        case ICDialogActionStyleDestructive:
            // 删除风格
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (@available(iOS 8.2, *)) {
                btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            }
            btn.backgroundColor = [UIColor colorWithRed:247/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
            btn.layer.borderColor = [UIColor colorWithRed:247/255.0 green:79/255.0 blue:79/255.0 alpha:1.0].CGColor;
            break;
        case ICDialogActionStyleCancel:
            // 取消风格
            [btn setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:109/255.0 alpha:1.0] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            btn.layer.borderColor = [UIColor colorWithRed:203/255.0 green:202/255.0 blue:207/255.0 alpha:1.0].CGColor;
            break;
        case ICDialogActionStyleDefault:
        default:
        {
            // 默认风格
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.backgroundColor = [UIColor colorWithRed:247/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
            btn.layer.borderColor = [UIColor colorWithRed:247/255.0 green:79/255.0 blue:79/255.0 alpha:1.0].CGColor;
            
        }
            break;
    }
    if (action.style == ICDialogActionStyleDefault) {
        
    }
    
    [self.bgView addSubview:btn];
    [self.actionList addObject:btn];

}

#pragma mark --- actionHandler

- (void)actionHandler:(UIButton *)sender {
    [self hideDialogView];
    NSUInteger tag = sender.tag - 1;
    ICDialogAction *dialogAction = self.dialogActions[tag];
    if (dialogAction.actionHandle) {
        dialogAction.actionHandle(dialogAction);
    }
}


#pragma mark --- 懒加载

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, 0, self.viewWidth, 0);
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 12;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth - 40, 0)];
        _contentLabel.textColor = [UIColor colorWithRed:4/255.0 green:28/255.0 blue:30/255.0 alpha:1.0];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = self.message;
         [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (ICDialogWebView *)webView {
    if (!_webView) {
        _webView = [[ICDialogWebView alloc] init];
        if ([self.message isKindOfClass:[NSString class]]) {
            if ([self.message hasPrefix:@"http"] || [self.message hasPrefix:@"file"]) {
                 [_webView loadWebviewWithURL:[NSURL URLWithString:self.message]];
            } else {
                 [_webView loadWebviewWithHtmlStr:self.message];
            }
        }
    }
    return _webView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 0)];
        if (@available(iOS 8.2, *)) {
            _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        }
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:4/255.0 green:28/255.0 blue:30/255.0 alpha:1.0];
        _titleLabel.numberOfLines = 3;
        _titleLabel.text = self.title;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (NSMutableArray<UIButton *> *)actionList {
    if (!_actionList) {
        _actionList = [NSMutableArray new];
    }
    return _actionList;
}

- (NSMutableArray<ICDialogAction *> *)dialogActions {
    if (!_dialogActions) {
        _dialogActions = [NSMutableArray new];
    }
    return _dialogActions;
}


#pragma mark --- public method
+ (instancetype)dialogViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(ICDialogViewStyle)preferredStyle {
    ICDialogView *dialogView = [[ICDialogView alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
    return dialogView;
}


- (void)addAction:(ICDialogAction *)action {
    [self addBtnWithAction:action];
}

- (void)showDialogViewToSuperView:(UIView *)superView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [superView addSubview:self];
        self.frame = superView.bounds;
        [self beginBgViewRect];
        [self showAnimation];
    });
}

- (void)hideDialogView {
    [self hideAnimation];
}


@end
