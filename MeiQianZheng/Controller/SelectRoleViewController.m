//
//  SelectRoleViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "SelectRoleViewController.h"
#import "SalesclerkManageViewController.h"
#import "CommodityListViewController.h"

@interface SelectRoleViewController ()

@end

@implementation SelectRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"角色选择";
    
    UIButton * consumerBtn = [[UIButton alloc] init];
    consumerBtn.tag = 10001;
    [consumerBtn addTarget:self action:@selector(pushController:) forControlEvents:UIControlEventTouchUpInside];
    [consumerBtn setTitle:@"消费者" forState:UIControlStateNormal];
    
    UIButton * cashierBtn = [[UIButton alloc] init];
    cashierBtn.tag = 10002;
    [cashierBtn setTitle:@"收银员" forState:UIControlStateNormal];
    [cashierBtn addTarget:self action:@selector(pushController:) forControlEvents:UIControlEventTouchUpInside];
    consumerBtn.backgroundColor = [UIColor redColor];
    cashierBtn.backgroundColor = [UIColor blueColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:consumerBtn];
    [self.view addSubview:cashierBtn];
    
    consumerBtn.translatesAutoresizingMaskIntoConstraints = NO;
    cashierBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[consumerBtn]-80-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(consumerBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[consumerBtn(==80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(consumerBtn,cashierBtn)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[cashierBtn(consumerBtn)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cashierBtn,consumerBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[consumerBtn]-80-[cashierBtn(consumerBtn)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(consumerBtn,cashierBtn)]];
    
}

- (void)pushController:(UIButton *)button
{
    UIViewController * controller = nil;
    if (button.tag == 10002) {
        controller = [[SalesclerkManageViewController alloc] init];
    } else {
        controller = [[CommodityListViewController alloc] init];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
