//
//  CommodityManageTool.m
//  ThoughtWorks
//
//  Created by msn on 16/5/25.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityManageTool.h"
#import "CommodityModel.h"
#import "FMDB.h"

static FMDatabase * _db;

@implementation CommodityManageTool

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
    NSLog(@"path = %@\n",path);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:path]) {
         [fileMgr removeItemAtPath:path error:nil];;
    };
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    
    // 2.创建商品信息表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_commodity_list (id integer PRIMARY KEY, barcode string NOT NULL , name string,unit string,categoryid string,category string,subcategory string,price real,discountype string);"];
    
    //3.创建商品种类表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_category (categoryid integer PRIMARY KEY,category string unique,isExistInShoppingCar integer)"];
    
    //4.创建优惠商品表(单品满100减10块)
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_discount_3 (id integer PRIMARY KEY, barcode string NOT NULL)"];
    
    //5.创建购物车商品列表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shoppingcar (id integer PRIMARY KEY, barcode string NOT NULL, name string,unit string,categoryid string,category string,subcategory string,price real,discountype string,count integer);"];
    
    //6.创建购物车商品种类表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shoppingcar_category (categoryid integer PRIMARY KEY,category string unique)"];
}

/*
  添加/更新 优惠商品信息
 */
+ (void) addDiscount_3:(NSArray *)barcodeArray {
    //先清空原来的优惠集合
    [_db executeUpdate:@"DELETE FROM t_discount_3 "];
    //再将新集合插入
    for (CommodityModel * item in barcodeArray) {
         [_db executeUpdateWithFormat:@"INSERT INTO t_discount_3 (barcode) VALUES (%@);",item.barcode];
    }
}

/*
 * 判断某个商品是否满足优惠
 */
+ (BOOL)isDiscountCommodity:(CommodityModel *)item{
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

+(void)addCommodityInList:(CommodityModel *)item{
    
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE barcode = %@",item.barcode];
    
    if (set.next) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_commodity_list WHERE barcode = %@",item.barcode];
    }
    
    //到t_category中查询，看是否已存在该category，如果没有则插入
    NSInteger categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    NSLog(@"categoryId = %zd\n",categoryId);
    if (categoryId == -1) {
       [_db executeUpdateWithFormat:@"INSERT INTO t_category (category) VALUES (%@);",item.category];
       categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    }
    [_db executeUpdateWithFormat:@"INSERT INTO t_commodity_list (barcode,name,unit,categoryid,category,subcategory,price,discountype) VALUES (%@,%@,%@,%ld,%@,%@,%f,%@);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,item.promotionType.count == 0?@"":item.promotionType[0]];
}

+ (void)addCommodityInShoppingCarAddOneOrReduceOne:(CommodityModel *)item {
    //1.首先到t_shoppingcar中查询，看是否已存在该item
    //得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE barcode = %@",item.barcode];
    NSInteger categoryId;
    if (set.next) {
        [_db executeQueryWithFormat:@"DELETE FROM t_shoppingcar WHERE barcode = %@",item.barcode];
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        
        [_db executeUpdateWithFormat:@"UPDATE t_shoppingcar SET barcode = %@,name = %@,unit = %@,categoryid = %ld,category = %@,subcategory = %@,price = %f,discountype = %@,count = %ld WHERE barcode = %@", item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,item.promotionType.count == 0?@"":item.promotionType[0],item.count , item.barcode];
    } else {
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        [_db executeUpdateWithFormat:@"INSERT INTO t_shoppingcar (barcode,name,unit,categoryid,category,subcategory,price,discountype,count) VALUES (%@,%@,%@,%ld,%@,%@,%f,%@,%ld);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,item.promotionType.count == 0?@"":item.promotionType[0],item.count];
    }
    [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",1,item.category];
}

+ (void)addCommodityInShoppingCar:(CommodityModel *)item {
    //1.首先到t_shoppingcar中查询，看是否已存在该item
    //得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE barcode = %@",item.barcode];
    NSInteger categoryId;
    if (set.next) {
        [_db executeQueryWithFormat:@"DELETE FROM t_shoppingcar WHERE barcode = %@",item.barcode];
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        NSInteger count = [set intForColumn:@"count"];
        
        [_db executeUpdateWithFormat:@"UPDATE t_shoppingcar SET barcode = %@,name = %@,unit = %@,categoryid = %ld,category = %@,subcategory = %@,price = %f,discountype = %@,count = %ld WHERE barcode = %@", item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,item.promotionType.count == 0?@"":item.promotionType[0],item.count + count , item.barcode];
    } else {
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        [_db executeUpdateWithFormat:@"INSERT INTO t_shoppingcar (barcode,name,unit,categoryid,category,subcategory,price,discountype,count) VALUES (%@,%@,%@,%ld,%@,%@,%f,%@,%ld);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,item.promotionType.count == 0?@"":item.promotionType[0],item.count];
    }
    [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",1,item.category];
}


+ (void)deleteCommodityFromShoppingCar:(CommodityModel *)item {
   
    BOOL result =  [_db executeUpdateWithFormat:@"DELETE FROM t_shoppingcar WHERE barcode = '%@'",item.barcode];
    NSLog(@"result = %zd\n",result);
    
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE category = %@",item.category];
    if (set.columnCount == 0) {
        [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",0,item.category];
    }
}

+ (NSInteger)queryCategoryTypeWithCategoryName:(NSString *)categoryName {
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category WHERE category = %@",categoryName];
    NSInteger categoryId = -1;
    while (set.next) {
        categoryId = [set intForColumn:@"categoryid"];
    }
    return categoryId;
}

+ (NSArray *)commoditiesWithCategory:(NSInteger)categoryId
{
    // 得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE categoryid = %ld",categoryId];
    // 不断往下取数据
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.barcode = [set stringForColumn:@"barcode"];
        commodity.name = [set stringForColumn:@"name"];
        commodity.unit = [set stringForColumn:@"unit"];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        commodity.price = [set doubleForColumn:@"price"];
        commodity.promotionType = [NSArray arrayWithObject:[set stringForColumn:@"discountype"]];
        commodity.subCategory = [set stringForColumn:@"subcategory"];
        [commodities addObject:commodity];
    }
    return commodities;
}

+ (NSArray *)commoditiesInShoppingCarWithCategory:(NSInteger)categoryId
{
    // 得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE categoryid = %ld",categoryId];
    // 不断往下取数据
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.barcode = [set stringForColumn:@"barcode"];
        commodity.name = [set stringForColumn:@"name"];
        commodity.unit = [set stringForColumn:@"unit"];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        commodity.price = [set doubleForColumn:@"price"];
        commodity.promotionType = [NSArray arrayWithObject:[set stringForColumn:@"discountype"]];
        commodity.subCategory = [set stringForColumn:@"subcategory"];
        commodity.count = [set intForColumn:@"count"];
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
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        [categories addObject:commodity];
    }
    return categories;
}

+ (NSArray *)categoriesInShoppingCar {
    
    // 得到结果集
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category WHERE isExistInShoppingCar = %d",1];
    // 不断往下取数据
    NSMutableArray * categories = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        [categories addObject:commodity];
    }
    return categories;
}

+ (NSArray *)commoditiesInShoppingCar
{
    // 得到结果集
    FMResultSet * set = [_db executeQuery:@"SELECT * FROM t_shoppingcar "];
    // 不断往下取数据
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.barcode = [set stringForColumn:@"barcode"];
        commodity.name = [set stringForColumn:@"name"];
        commodity.unit = [set stringForColumn:@"unit"];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        commodity.price = [set doubleForColumn:@"price"];
        commodity.promotionType = [NSArray arrayWithObject:[set stringForColumn:@"discountype"]];
        commodity.subCategory = [set stringForColumn:@"subcategory"];
        commodity.count = [set intForColumn:@"count"];
        [commodities addObject:commodity];
    }
    return commodities;
}

/*
 *
 */
@end
