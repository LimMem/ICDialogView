//
//  ICDialogAction.m
//  ICKit_Example
//
//  Created by 秦传龙 on 2020/7/23.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import "ICDialogAction.h"

@implementation ICDialogAction

+ (instancetype)actionWithTitle:(NSString *)title style:(ICDialogActionStyle)style handler:(void (^)(ICDialogAction * _Nonnull))handler {
    ICDialogAction *action = [[ICDialogAction alloc] initWithTitle:title style:style handler:handler];
    return action;
    
}

- (instancetype)initWithTitle:(NSString *)title style:(ICDialogActionStyle)style handler:(void (^)(ICDialogAction * _Nonnull))handler {
    self = [super init];
    if (self) {
        _style = style;
        _title = title;
        // 初始化一下 防止崩溃
        self.actionHandle = ^(ICDialogAction *action) {};
        if (handler) {
            self.actionHandle = handler;
        }
    }
    return self;
}


@end
