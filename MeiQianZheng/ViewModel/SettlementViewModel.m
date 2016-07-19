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
    }
    return self;
}

-(void)setShoppingcarCommodities:(NSArray *)shoppingcarCommodities
{
    NSLog(@"shoppingcarCommodities = %@\n",shoppingcarCommodities);
    [_shoppingcarCommodities removeAllObjects];
    for (NSArray * arr in shoppingcarCommodities) {
        for (CommodityModel * model in arr) {
            [_shoppingcarCommodities addObject:model];
            [CommodityManageTool addCommodityInShoppingCar:model];
        }
    }
    NSLog(@"shoppingcarCommodities = %@\n",shoppingcarCommodities);
    NSLog(@"_shoppingcarCommodities = %@\n",_shoppingcarCommodities);
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
//    NSString * orders = [self toNSStringWithNSArray:params];
    NSDictionary * param = @{@"order":orders};
    NSLog(@"param = %@\n",param);
    
    [HttpTool postWithBaseURL:baseUrl path:orderPattern params:param success:^(id JSON) {
        NSLog(@"json = %@\n",JSON);
//        NSDictionary * result =[NSJSONSerialization JSONObjectWithStream:JSON options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"result = %@\n",result);
//        callback(result);
    } failure:^(NSError *error) {
        NSLog(@"结算失败%@\n",error.localizedDescription);
    }];
}

@end
