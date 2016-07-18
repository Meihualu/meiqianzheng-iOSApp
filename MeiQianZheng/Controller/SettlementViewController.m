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
@property (nonatomic,strong) UITextView          * infoView;

@end

@implementation SettlementViewController

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
    [self scanCommoditiyBarcode];
    [self.viewModel settlementWithSettlementCallBack:^(NSString *result) {
        NSLog(@"result = %@\n",result);
        [self createBillWithInfo:result];
    }];
    
    
}

#pragma  mark --模拟收银员扫描商品二维码
- (void)scanCommoditiyBarcode{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString * scanInfo = @"正在扫描...";
        NSString * info = nil;
        
        for (CommodityModel * item in _viewModel.shoppingcarCommodities) {
            if (item.count > 1) {
                info = [NSString stringWithFormat:@"%@-%zd",item.barcode,item.count];
                scanInfo = [NSString stringWithFormat:@"%@\n%@",scanInfo,info];
            } else {
                info = [NSString stringWithFormat:@"%@",item.barcode];
                scanInfo = [NSString stringWithFormat:@"%@\n%@",scanInfo,info];
            }
            [NSThread sleepForTimeInterval:1.0f];
            // 更新界面
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_infoView setText:scanInfo];
            });
        }
    });
}

#pragma  mark --模拟收银员生成小票
- (void)createBillWithInfo:(NSString *)billInfo{
    
    _infoView.text = @"";
    
    //在子线程中计算小票信息   在主线程中更新页面UI
    dispatch_queue_t queue = dispatch_queue_create("cn.uestc.zyl", NULL);
    dispatch_async(queue, ^{
        NSMutableString * info = [NSMutableString stringWithFormat:@"*<没钱赚商店>购物清单* \n%@",billInfo];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self appendContent:info];
        });
            [NSThread sleepForTimeInterval:1.0f];
            // 更新界面
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self appendContent:info];
            });
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0f];
        // 更新界面
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self appendContent:@""];
        });
    });
}

#pragma mark -- 追加多行文本框内容
- (void)appendContent:(NSString *)text
{
    // 1. 取出textView中的当前文本内容
    NSMutableString *str = [NSMutableString stringWithString:_infoView.text];
    // 2. 将text追加至textView内容的末尾
    [str appendFormat:@"%@\n", text];
    // 3. 使用追加后的文本，替换textView中的内容
    [_infoView setText:str];
    // 4. 将textView滚动至视图底部，保证能够及时看到新追加的内容
    NSRange range = NSMakeRange(str.length - 1, 1);
    [_infoView scrollRangeToVisible:range];
}


@end
