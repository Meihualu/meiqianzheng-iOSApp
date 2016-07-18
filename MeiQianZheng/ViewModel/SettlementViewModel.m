//
//  SettlementViewModel.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "SettlementViewModel.h"

@implementation SettlementViewModel

- (void)settlementWithSettlementCallBack:(settlementCallBack)callback
{
    //https://meiqianzheng.herokuapp.com/order
    NSMutableArray * params = [NSMutableArray array];
    NSArray * commodities = [CommodityManageTool commoditiesInShoppingCar];
    for (CommodityModel * model in commodities) {
        NSString * barcode = model.barcode;
        if (model.count > 0) {
            barcode = [NSString stringWithFormat:@"%@-%zd",barcode,model.count];
        }
        [params addObject:barcode];
    }
    
    [HttpTool postWithBaseURL:baseUrl path:orderPattern paramsArrray:params success:^(id JSON) {
        NSString * result =[NSJSONSerialization JSONObjectWithStream:JSON options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"json = %@\n",JSON);
        NSLog(@"result = %@\n",result);
        callback(result);
    } failure:^(NSError *error) {
        
    }];
    
}


@end
