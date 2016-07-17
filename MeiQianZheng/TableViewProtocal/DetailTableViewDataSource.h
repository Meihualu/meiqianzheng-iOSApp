//
//  DetailTableViewDataSource.h
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"

@interface DetailTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) CommodityModel * model;

@end
