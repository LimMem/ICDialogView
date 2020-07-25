//
//  ICDialogView.h
//  ICKit_Example
//
//  Created by 秦传龙 on 2020/7/23.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICDialogAction.h"

typedef NS_ENUM(NSInteger, ICDialogViewStyle) {
    ICDialogViewStyleAlert,   // 中间alert弹出方式
    ICDialogViewStyleWebAlertView // 中间视图是个webview
};

NS_ASSUME_NONNULL_BEGIN

@interface ICDialogView : UIView

/*
 *初始化设置dialogView
 *特殊说明：当preferredStyle为ICDialogViewStyleWebAlertView时， message可以传urlString和htmlStr
 *
 */
+ (instancetype)dialogViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(ICDialogViewStyle)preferredStyle;

/* 添加action配置按钮   addAction 3个 就竖向排列 */
- (void)addAction:(ICDialogAction *)action;

/* 将视图增加到父视图上 */
- (void)showDialogViewToSuperView:(UIView *)view;

/* 隐藏视图 */
- (void)hideDialogView;


@end

NS_ASSUME_NONNULL_END
