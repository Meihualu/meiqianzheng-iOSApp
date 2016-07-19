//
//  ShoppingCarViewModel.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarViewModel.h"
#import "CommodityModel.h"

@implementation ShoppingCarViewModel
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
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray * categories = [CommodityManageTool categoriesInShoppingCar];
            for (CommodityModel * item in categories) {
                NSArray * array = [CommodityManageTool commoditiesInShoppingCarWithCategory:item.categoryId];
                [_dataSource addObject:array];
            }
            callback(categories,_dataSource);
        });
    });
}

- (void )footerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}

@end
