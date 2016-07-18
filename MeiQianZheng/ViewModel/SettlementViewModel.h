//
//  SettlementViewModel.h
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^settlementCallBack) (NSString * result);

@interface SettlementViewModel : NSObject

@property (nonatomic,strong) NSArray * shoppingcarCommodities;

//结算
- (void)settlementWithSettlementCallBack:(settlementCallBack)callback;

@end
