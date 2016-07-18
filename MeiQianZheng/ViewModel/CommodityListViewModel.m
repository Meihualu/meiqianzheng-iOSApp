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
            for (int i = 0; i < 20; i ++) {
                
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                
                [CommodityManageTool addCommodityInList:item];
            }
             
            /* */
            NSArray * categories = [CommodityManageTool categories];
            
            for (CommodityModel * item in categories) {
                NSArray * array = [CommodityManageTool commoditiesWithCategory:item.categoryId];
                [_dataSource addObject:array];
            }
            
            callback(categories,_dataSource);
            
            
            /*
             http://37fd72bc.ngrok.io/products/
             https://meiqianzheng.herokuapp.com/products/food
             */
            /*
            [HttpTool getWithBaseURL:baseUrl productsPattern params:nil success:^(id JSON) {
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
                NSLog(@"error.localizedDescription = %@\n",error.localizedDescription);
            }];
           */
        });
    });
}

- (void )footerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程刷新视图
//            callback(arr);
        });
    });
}

@end
