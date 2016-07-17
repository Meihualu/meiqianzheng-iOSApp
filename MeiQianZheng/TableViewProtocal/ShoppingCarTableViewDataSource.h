//
//  ShoppingCarTableViewDataSource.h
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NSArray * categories;

@end

