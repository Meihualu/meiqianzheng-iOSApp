//
//  CommodityListViewModel.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityListViewModel.h"
#import "CommodityModel.h"
@interface CommodityListViewModel()

@end

@implementation CommodityListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)headerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /**/
            [HttpTool getWithBaseURL:baseUrl  path:productsPattern params:nil success:^(id JSON) {
                NSMutableArray * result = [[NSMutableArray alloc] init];
                [result addObjectsFromArray:JSON];
                NSLog(@"result = %@\n",result);
                for (NSDictionary * dict in result) {
                    CommodityModel * item = [[CommodityModel alloc] initWithDict:dict];
                     [CommodityManageTool addCommodityInList:item];
                }
                
                NSArray * categories = [CommodityManageTool categories];
                
                for (CommodityModel * item in categories) {
                    NSArray * array = [CommodityManageTool commoditiesWithCategory:item.categoryId];
                    [_dataSource addObject:array];
                }
                
                callback(categories,_dataSource);
                
            } failure:^(NSError *error) {
                callback([NSArray array],[NSArray array]);
            }];
           
        });
    });
}

- (void )footerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray * categories =[NSArray array];
            NSArray * items = [NSArray array];
            callback(categories,items);
        });
    });
}

-(void)filterCommoditiesWithPromotionType:(NSString *)promotionType callback:(callback)callback;
{
    [_dataSource removeAllObjects];
    NSArray * categories = nil;
    if ([promotionType isEqualToString:kDiscountAllTypes]) {
        categories = [CommodityManageTool categories];
        for (CommodityModel * item in categories) {
            NSArray * array = [CommodityManageTool allSalesCommoditiesWithCategory:item.categoryId];
            [_dataSource addObject:array];
        }
    } else if ([promotionType isEqualToString:@"commodityAll"]) {
        categories = [CommodityManageTool categories];
        for (CommodityModel * item in categories) {
            NSArray * array = [CommodityManageTool commoditiesWithCategory:item.categoryId];
            [_dataSource addObject:array];
        }
    } else {
        categories = [CommodityManageTool categories];
        for (CommodityModel * item in categories) {
            NSArray * array = [CommodityManageTool commoditiesWithCategory:item.categoryId promotionType:promotionType];
            [_dataSource addObject:array];
        }
    }
    callback(categories,_dataSource);
}
@end
