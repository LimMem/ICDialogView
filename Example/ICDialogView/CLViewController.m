//
//  CLViewController.m
//  ICDialogView
//
//  Created by LimMem on 07/25/2020.
//  Copyright (c) 2020 LimMem. All rights reserved.
//

#import "CLViewController.h"
#import "ICDialogView.h"
#import "ICDialogAction.h"


@interface CLViewController ()

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ICDialogView *dialogView = [ICDialogView dialogViewWithTitle:@"我是头部" message:@"https://www.taobao.com" preferredStyle:ICDialogViewStyleWebAlertView];
    [dialogView addAction: [ICDialogAction actionWithTitle:@"确定" style:ICDialogActionStyleDefault handler:^(ICDialogAction * _Nonnull action) {
        NSLog(@"%@ === ", action.title);
    }]];
    [dialogView addAction: [ICDialogAction actionWithTitle:@"取消" style:ICDialogActionStyleCancel handler:^(ICDialogAction * _Nonnull action) {
         NSLog(@"%@ === ", action.title);
    }]];

    [dialogView showDialogViewToSuperView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
