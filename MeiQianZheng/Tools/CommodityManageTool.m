//
//  CommodityManageTool.m
//  ThoughtWorks
//
//  Created by msn on 16/5/25.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityManageTool.h"
#import "CommodityItem.h"
#import "FMDB.h"

static FMDatabase * _db;

@implementation CommodityManageTool

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    NSLog(@"path = %@\n",path);
    [_db open];
    
    // 2.创建商品信息表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_commodity (id integer PRIMARY KEY, barcode string NOT NULL, name string,unit string,categoryid string,category string,subcategory string,price real,discountype integer);"];
    
    //3.创建商品种类表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_category (categoryid integer PRIMARY KEY,category string unique)"];
    
    //4.创建优惠商品表(单品满100减10块)
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_discount_3 (id integer PRIMARY KEY, barcode string NOT NULL)"];
    
}

/*
  添加/更新 优惠商品信息
 */
+ (void) addDiscount_3:(NSArray *)barcodeArray {
    //先清空原来的优惠集合
    [_db executeUpdate:@"DELETE FROM t_discount_3 "];
    //再将新集合插入
    for (CommodityItem * item in barcodeArray) {
         [_db executeUpdateWithFormat:@"INSERT INTO t_discount_3 (barcode) VALUES (%@);",item.barcode];
    }
}

/*
 * 判断某个商品是否满足优惠
 */
+ (BOOL)isDiscountCommodity:(CommodityItem *)item{
    // 得到结果集
    FMResultSet * set = [_db executeQuery:@"SELECT * FROM t_discount_3;"];
    // 不断往下取数据
    while (set.next) {
        // 获得当前所指向的数据
        NSString * barcode = [set stringForColumn:@"barcode"];
        if ([barcode isEqualToString:item.barcode]) {
            return YES;
        }
    }
    return NO;
}


+(void)addCommodity:(CommodityItem *)item{
    
    //1.首先到t_category中查询，看是否已存在该category，如果没有则插入
    NSInteger categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    NSLog(@"categoryId = %zd\n",categoryId);
    if (categoryId == -1) {
       [_db executeUpdateWithFormat:@"INSERT INTO t_category (category) VALUES (%@);",item.category];
       categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    }
    
    NSLog(@"商品的categoryId = %zd\n",categoryId);
    [_db executeUpdateWithFormat:@"INSERT INTO t_commodity (barcode,name,unit,categoryid,category,subcategory,price,discountype) VALUES (%@,%@,%@,%ld,%@,%@,%f,%ld);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,(long)item.discountType];
}

+ (NSInteger)queryCategoryTypeWithCategoryName:(NSString *)categoryName {
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category WHERE category = %@",categoryName];
    NSInteger categoryId = -1;
    while (set.next) {
        categoryId = [set intForColumn:@"categoryid"];
        NSLog(@"查询结果categoryId = %zd\n",categoryId);
    }
    return categoryId;
}

+ (NSArray *)commoditiesWithCategory:(NSInteger)categoryId
{
    // 得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity WHERE categoryid = %d",categoryId];
    // 不断往下取数据
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityItem * commodity = [[CommodityItem alloc] init];
        commodity.barcode = [set stringForColumn:@"barcode"];
        commodity.name = [set stringForColumn:@"name"];
        commodity.unit = [set stringForColumn:@"unit"];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        commodity.price = [set doubleForColumn:@"price"];
        commodity.discountType = [set intForColumn:@"discountype"];
        commodity.subCategory = [set stringForColumn:@"subcategory"];
        [commodities addObject:commodity];
    }
    return commodities;
}

+ (NSArray *)categories {
    
    // 得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category "];
    // 不断往下取数据
    NSMutableArray * categories = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityItem * commodity = [[CommodityItem alloc] init];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        [categories addObject:commodity];
    }
    return categories;
}


/*
 *
 */
@end
