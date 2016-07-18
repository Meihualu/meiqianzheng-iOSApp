//
//  ShoppingCarCell.h
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

@interface ShoppingCarCell : UITableViewCell

@property (nonatomic,strong) CommodityModel * model;
- (void)setCount;

@property (nonatomic,assign) CGFloat cellHeight;

@end
