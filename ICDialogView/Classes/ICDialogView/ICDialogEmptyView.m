//
//  ICDialogEmptyView.m
//  CLKit_Example
//
//  Created by 秦传龙 on 2020/7/25.
//  Copyright © 2020 LimMem. All rights reserved.
//

#import "ICDialogEmptyView.h"

@interface ICDialogEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descriptLabel;
@property (nonatomic, strong) UIButton *reloadBtn;

@end


@implementation ICDialogEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
