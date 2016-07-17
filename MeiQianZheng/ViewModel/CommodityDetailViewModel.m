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
    NSLog(@"self.model.count = %zd\n",self.model.count);
}

/**
 *  处理减少商品数量”-“点击事件
 */
- (void)reduceNumberOfItem{
    if (self.model.count > 0) {
        self.model.count --;
    }
    NSLog(@"self.model.count = %zd\n",self.model.count);
}

/**
 *  处理添加到购物车逻辑
 */
- (void)addShoppingCar{
    
    [CommodityManageTool addCommodityInShoppingCar:_model];
    
    for (CommodityModel * item in _shoppingCar) {
        if ([item.barcode isEqualToString:_model.barcode]) {
            [_shoppingCar removeObject:item];
        }
    }
    [_shoppingCar addObject:_model];
}

@end
