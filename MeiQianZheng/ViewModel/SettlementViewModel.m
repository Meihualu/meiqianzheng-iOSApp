//
//  SettlementViewModel.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "SettlementViewModel.h"

@implementation SettlementViewModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _shoppingcarCommodities = [NSMutableArray array];
        _scanInfoArray = [NSMutableArray array];
    }
    return self;
}

-(void)setShoppingcarCommodities:(NSArray *)shoppingcarCommodities
{
    [_shoppingcarCommodities removeAllObjects];
    for (NSArray * arr in shoppingcarCommodities) {
        for (CommodityModel * model in arr) {
            [_shoppingcarCommodities addObject:model];
            [CommodityManageTool addCommodityInShoppingCar:model];
        }
    }
}

- (void)settlementWithSettlementCallBack:(settlementCallBack)callback
{
    NSMutableArray * params = [NSMutableArray array];
    NSString * orders = @"";
    for (CommodityModel * model in _shoppingcarCommodities) {
        NSString * barcode = model.barcode;
        
        if(model.count == 0){
            continue;
        } else if (model.count > 1) {
            barcode = [NSString stringWithFormat:@"%@-%zd",barcode,model.count];
        }
        [params addObject:barcode];
        if (orders.length == 0) {
            orders = [NSString stringWithFormat:@"[%@'%@'",orders,barcode];
        } else {
            orders = [NSString stringWithFormat:@"%@,'%@'",orders,barcode];
        }
    }
    
    orders = [NSString stringWithFormat:@"%@]",orders];
    NSDictionary * param = @{@"order":orders};
    
    [HttpTool postWithBaseURL:baseUrl path:orderPattern params:param success:^(id JSON) {
        NSDictionary * result = (NSDictionary *)JSON;
        NSString * str = result[@"output"];
        callback(str);
    } failure:^(NSError *error) {
        callback(@"系统结算故障，请稍后重试~");
    }];
}

#pragma  mark --模拟收银员扫描商品二维码
- (void)scanCommoditiyBarcode{
    [_scanInfoArray addObject:@"正在扫描..."];
    for (CommodityModel * item in _shoppingcarCommodities) {
        NSString * scanInfo = @"";
        NSString * info = nil;
        if (item.count > 1) {
            info = [NSString stringWithFormat:@"%@-%zd",item.barcode,item.count];
            scanInfo = [NSString stringWithFormat:@"%@\n%@",scanInfo,info];
        } else {
            info = [NSString stringWithFormat:@"%@",item.barcode];
            scanInfo = [NSString stringWithFormat:@"%@\n%@",scanInfo,info];
        }
        [_scanInfoArray addObject:scanInfo];
    }
    [_scanInfoArray addObject:@"\n正在结算，请稍后..."];
}

#pragma mark -- 追加多行文本框内容
- (void)appendContent:(NSString *)text textView:(UITextView *)infoView
{
    NSMutableString *str = [NSMutableString stringWithString:infoView.text];
    [str appendFormat:@"%@\n", text];
    [infoView setText:str];
    NSRange range = NSMakeRange(str.length - 1, 1);
    [infoView scrollRangeToVisible:range];
}

@end
