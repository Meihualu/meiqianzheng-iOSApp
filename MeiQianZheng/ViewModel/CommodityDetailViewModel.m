//
//  CommodityDetailViewModel.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityDetailViewModel.h"
@interface CommodityDetailViewModel ()

@property (nonatomic,strong) NSMutableArray * shoppingCar;
@property (nonatomic,assign) BOOL isAdd;

@end

@implementation CommodityDetailViewModel

- (void)dealTextFieldTextChangeWithText:(NSString *)text{
//    self.model.count = [text integerValue];
    [self.model setCount:[text integerValue]];
    
}

/**
 *  处理添加商品数量”+“点击事件
 */
- (void)addNumberOfItem{
    self.model.count = self.model.count + 1;
}

/**
 *  处理减少商品数量”-“点击事件
 */
- (void)reduceNumberOfItem{
    if (self.model.count > 0) {
        self.model.count --;
    }
}

/**
 *  处理添加到购物车逻辑
 */
- (void)addShoppingCar{
    if (_model.count > 0) {
        [CommodityManageTool addCommodityInShoppingCar:_model];
    }
    self.isAdd = YES;
}

/**
 * 立即购买
 */
- (void)purchaseRightNow
{
    if (!self.isAdd) {
        [self addShoppingCar];
    }
}

- (NSString *)getPrompt{
    NSString * prompt = nil;
    if (_model.count == 0) {
        prompt = @"请选择商品的数量";
    }else{
        prompt = [NSString stringWithFormat:@"已成功将商品添加进购物车：商品名：%@ 数量：%zd",_model.name,_model.count];
    }
    return prompt;
}

@end
