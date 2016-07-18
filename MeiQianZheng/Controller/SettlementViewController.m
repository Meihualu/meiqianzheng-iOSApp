//
//  SettlementViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "SettlementViewController.h"
#import "SettlementViewModel.h"

@interface SettlementViewController ()

@property (nonatomic,strong) SettlementViewModel * viewModel;

@end

@implementation SettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算清单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _viewModel = [[SettlementViewModel alloc] init];
    
    [self.viewModel settlementWithSettlementCallBack:^(NSString *result) {
        NSLog(@"result = %@\n",result);
    }];
}

@end
