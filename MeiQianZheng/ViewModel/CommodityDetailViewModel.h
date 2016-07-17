//
//  CommodityDetailViewModel.h
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"

@interface CommodityDetailViewModel : NSObject

@property (nonatomic,strong) CommodityModel * model;

/**
 *  处理UITextField itemCount 输入变化
 */
- (void)dealTextFieldTextChangeWithText:(NSString *)text;
/**
 *  处理添加商品数量”+“点击事件
 */
- (void)addNumberOfItem;
/**
 *  处理减少商品数量”-“点击事件
 */
- (void)reduceNumberOfItem;
/**
 *  处理添加到购物车逻辑
 */
- (void)addShoppingCar;

@end
