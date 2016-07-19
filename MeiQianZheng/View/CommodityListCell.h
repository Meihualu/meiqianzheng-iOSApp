//
//  CommodityListCell.h
//  MeiQianZheng
//
//  Created by msn on 16/7/14.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"


@interface CommodityListCell : UITableViewCell

@property (nonatomic,strong) CommodityModel * model;
@property (nonatomic,assign) CGFloat cellHeight;

@end
