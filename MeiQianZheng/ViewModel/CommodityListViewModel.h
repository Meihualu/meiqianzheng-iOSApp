//
//  CommodityListViewModel.h
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^callback) (NSArray *category , NSArray*dataSource);
@interface CommodityListViewModel : NSObject

@property (nonatomic,strong) NSMutableArray * dataSource;
//tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCallback:(callback)callback;

//tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCallback:(callback)callback;


@end
