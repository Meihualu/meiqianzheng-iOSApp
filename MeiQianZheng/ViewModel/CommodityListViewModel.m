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

@property (nonatomic,strong) NSMutableArray * dataSource;

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
            /*
              http://f74b59f1.ngrok.io/products
              http://c80db024.ngrok.io/products
             */
            /*
            [HttpTool getWithBaseURL:@"http://c80db024.ngrok.io" path:@"products" params:nil success:^(id JSON) {
                NSMutableArray * result = [[NSMutableArray alloc] init];
                [result addObjectsFromArray:JSON];
                for (NSDictionary * dict in result) {
                    CommodityModel * item = [[CommodityModel alloc] initWithDict:dict];
                    [_dataSource addObject:item];
                }
                callback(_dataSource);
            } failure:^(NSError *error) {
                NSLog(@"error.localizedDescription = %@\n",error.localizedDescription);
            }];
           */ 
        });
    });
}

- (void)headerRefreshRequestWithCallback_bak:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
//            callback(arr);
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
