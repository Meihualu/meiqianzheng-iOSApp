//
//  CommodityManageTool.h
//  ThoughtWorks
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityModel.h"

@interface CommodityManageTool : NSObject

/**
 *  获得所有的商品种类
 *
 *  @return 商品种类
 */
+ (NSArray *)categories;
/**
 *  获取购物车中的商品的种类
 *
 *  @return 商品种类
 */
+ (NSArray *)categoriesInShoppingCar;


/**
 *  根据商品种类Id获取商品
 *
 *  @param categoryId 目标商品的种类Id
 *
 *  @return 商品列表
 */
+ (NSArray *)commoditiesWithCategory:(NSInteger )categoryId;
/**
 *  根据商品种类Id和优惠类型获取商品列表
 *
 *  @param categoryId    商品种类Id
 *  @param promotionType 优惠类型
 *
 *  @return 商品列表
 */
+ (NSArray *)commoditiesWithCategory:(NSInteger)categoryId  promotionType:(NSString *)promotionType;
/**
 *  获取所有的优惠商品信息
 *
 *  @param categoryId 商品种类Id
 *
 *  @return 商品列表
 */
+ (NSArray *)allSalesCommoditiesWithCategory:(NSInteger)categoryId;
/**
 *  根据种类Id获取购物车中的商品列表
 *
 *  @param categoryId 商品种类Id
 *
 *  @return 商品列表
 */
+ (NSArray *)commoditiesInShoppingCarWithCategory:(NSInteger)categoryId;
/**
 *  获取购物车中的所有商品
 *
 *  @return 商品列表
 */
+ (NSArray *)commoditiesInShoppingCar;

/**
 *  向商品列表中添加一个商品
 *
 *  @param item 商品
 */
+ (BOOL)addCommodityInList:(CommodityModel *)item;
/**
 *  向购物车中添加一个商品
 *
 *  @param item 商品
 */
+ (BOOL)addCommodityInShoppingCar:(CommodityModel *)item;
/**
 *  修改购物车中商品的数量：增加一个或减少一个
 *
 *  @param item 商品
 */
+ (BOOL)addCommodityInShoppingCarAddOneOrReduceOne:(CommodityModel *)item ;


/**
 *  从购物车中删除一个商品
 *
 *  @param item 要删除的商品
 */
+ (BOOL)deleteCommodityFromShoppingCar:(CommodityModel *)item;

/**
 *  清空购物车
 */
+ (BOOL)clearShoppingCar;

@end
