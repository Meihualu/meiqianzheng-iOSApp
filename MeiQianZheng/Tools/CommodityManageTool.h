//
//  CommodityManageTool.h
//  ThoughtWorks
//
//  Created by msn on 16/5/25.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommodityItem;

@interface CommodityManageTool : NSObject

+ (NSArray *)categories;
+ (NSArray *)commoditiesWithCategory:(NSInteger )categoryId;
+ (void) addCommodity:(CommodityItem *)item;
+ (BOOL)isDiscountCommodity:(CommodityItem *)item;
+ (void) addDiscount_3:(NSArray *)barcodeArray;

@end
