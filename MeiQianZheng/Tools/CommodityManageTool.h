//
//  CommodityManageTool.h
//  ThoughtWorks
//
//  Created by msn on 16/5/25.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"

@interface CommodityManageTool : NSObject

+ (NSArray *)categories;
+ (NSArray *)categoriesInShoppingCar;

+ (NSArray *)commoditiesWithCategory:(NSInteger )categoryId;
+ (NSArray *)commoditiesInShoppingCarWithCategory:(NSInteger)categoryId;
+ (NSArray *)commoditiesInShoppingCar;

+ (void)addCommodityInList:(CommodityModel *)item;
+ (void)addCommodityInShoppingCar:(CommodityModel *)item;
+ (void)addCommodityInShoppingCarAddOneOrReduceOne:(CommodityModel *)item ;

+ (BOOL)isDiscountCommodity:(CommodityModel *)item;
+ (void) addDiscount_3:(NSArray *)barcodeArray;

+ (void)deleteCommodityFromShoppingCar:(CommodityModel *)item;

@end
