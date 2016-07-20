//
//  SettlementViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "SettlementViewController.h"
#import "SettlementViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SettlementViewController ()

@property (nonatomic,strong) SettlementViewModel * viewModel;
@property (nonatomic,strong) UITextView          * infoView;
@property (nonatomic,copy)   NSArray             * commodities;
@property (nonatomic,strong) refreshBack           refreshBack;

@end

@implementation SettlementViewController

- (instancetype)initWithCommodities:(NSArray *)commodities settleBack:(refreshBack)refreshBack
{
    self = [super init];
    if (self) {
        _commodities = [commodities copy];
        _refreshBack = refreshBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算清单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = kDefaultBackgroundColor;
    self.title = @"结算";
    
    UITextView * infoView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kViewWidth - 20, kViewHeight - kApplicationFrameHeight - 20)];
    infoView.editable = NO;
    infoView.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:infoView];
    _infoView = infoView;
    
    _viewModel = [[SettlementViewModel alloc] init];
    _viewModel.shoppingcarCommodities = [NSMutableArray arrayWithArray:_commodities];
    
    [self scanCommoditiyBarcode];
    
    
}

#pragma  mark --模拟收银员扫描商品二维码
- (void)scanCommoditiyBarcode{
    [_viewModel scanCommoditiyBarcode];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        for (NSString * str  in _viewModel.scanInfoArray) {
            [NSThread sleepForTimeInterval:1.0f];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_viewModel appendContent:str textView:_infoView];
            });
        }
        [self.viewModel settlementWithSettlementCallBack:^(NSString *result) {
            [self createBillWithInfo:result];
        }];
    });
}

#pragma  mark --模拟收银员生成小票
- (void)createBillWithInfo:(NSString *)billInfo{
    _infoView.text = @"";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1.0f];
        // 更新界面
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_viewModel appendContent:billInfo textView:_infoView];
            NSLog(@"billInfo = %@\n",billInfo);
            if (![billInfo isEqualToString:@"系统结算故障，请稍后重试~"]) {
                [CommodityManageTool clearShoppingCar];
                _refreshBack();
            }
        });
    });
}
@end
