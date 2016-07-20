//
//  SettlementViewController.h
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^refreshBack)();
@interface SettlementViewController : UIViewController


- (instancetype)initWithCommodities:(NSArray *)commodities settleBack:(refreshBack)refreshBack;

@end
