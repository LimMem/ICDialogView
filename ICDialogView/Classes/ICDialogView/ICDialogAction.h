//
//  ICDialogAction.h
//  ICKit_Example
//
//  Created by 秦传龙 on 2020/7/23.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICDialogAction;

typedef void(^OnActionHandle)(ICDialogAction * _Nullable action);

typedef NS_ENUM(NSInteger, ICDialogActionStyle) {
    ICDialogActionStyleDefault = 0, // 红背白字 系统常规字体
    ICDialogActionStyleCancel,  // 取消 白背黑字
    ICDialogActionStyleDestructive // 红背白字字体加粗
};

NS_ASSUME_NONNULL_BEGIN
@interface ICDialogAction : NSObject

@property (nullable, nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) ICDialogActionStyle style;
@property (nonatomic, copy) OnActionHandle actionHandle;


+ (instancetype)actionWithTitle:(nullable NSString *)title style:(ICDialogActionStyle)style handler:(void (^)(ICDialogAction *action))handler;


@end

NS_ASSUME_NONNULL_END
