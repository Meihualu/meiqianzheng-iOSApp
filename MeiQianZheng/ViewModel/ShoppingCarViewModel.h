//
//  ShoppingCarViewModel.h
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"

@interface ShoppingCarViewModel : NSObject

+ (NSArray *)categories;
+ (NSArray *)commoditiesWithCategory:(NSInteger )categoryId;
+ (void) addCommodity:(CommodityModel *)item;
+ (BOOL)isDiscountCommodity:(CommodityModel *)item;
+ (void) addDiscount_3:(NSArray *)barcodeArray;

@end
