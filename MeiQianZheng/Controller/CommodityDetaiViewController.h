//
//  CommodityDetaiViewController.h
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

@interface CommodityDetaiViewController : UIViewController

@property (nonatomic,strong) CommodityModel *model;

-(instancetype)initWithCommodityModel:(CommodityModel *)model;

@end
