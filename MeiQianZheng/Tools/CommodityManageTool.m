//
//  CommodityManageTool.m
//  ThoughtWorks
//
//  Created by msn on 16/7/17.
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
    
    //4.创建购物车商品列表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shoppingcar (id integer PRIMARY KEY, barcode string , name string,unit string,categoryid string,category string,subcategory string,price real,discountype string,count integer);"];
    //5.创建购物车商品种类表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shoppingcar_category (categoryid integer PRIMARY KEY,category string unique)"];
}

#pragma mark --向商品列表中添加商品
+(BOOL)addCommodityInList:(CommodityModel *)item{
    if (item == nil) {
        return false;
    }
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE barcode = %@",item.barcode];
    if (set.next) {
        [_db executeUpdateWithFormat:@"DELETE FROM t_commodity_list WHERE barcode = %@",item.barcode];
    }
    NSInteger categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    if (categoryId == -1) {
       [_db executeUpdateWithFormat:@"INSERT INTO t_category (category) VALUES (%@);",item.category];
       categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
    }
    
    NSString * promotionType = @"";
    if (item.promotionType.count > 0) {
        promotionType = item.promotionType[0];
        if (item.promotionType.count > 1) {
            promotionType = @"salesAll";
        }
    }
    [_db executeUpdateWithFormat:@"INSERT INTO t_commodity_list (barcode,name,unit,categoryid,category,subcategory,price,discountype) VALUES (%@,%@,%@,%ld,%@,%@,%f,%@);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,promotionType];
    return true;
}

+ (BOOL)addCommodityInShoppingCarAddOneOrReduceOne:(CommodityModel *)item {
    
    if(item == nil||item.barcode == nil)
        return false;
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE barcode = %@",item.barcode];
    NSInteger categoryId;
    NSString * promotionType = @"";
    if (item.promotionType.count > 0) {
        promotionType = item.promotionType[0];
        if (item.promotionType.count > 1) {
            promotionType = @"salesAll";
        }
    }
    if (set.next) {
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        [_db executeUpdateWithFormat:@"UPDATE t_shoppingcar SET barcode = %@,name = %@,unit = %@,categoryid = %ld,category = %@,subcategory = %@,price = %f,discountype = %@,count = %ld WHERE barcode = %@", item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,promotionType,item.count , item.barcode];
    }
    [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",1,item.category];
    return true;
}

+ (BOOL)addCommodityInShoppingCar:(CommodityModel *)item
{
    if (item == nil || item.barcode == nil) {
        return false;
    }
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE barcode = %@",item.barcode];
    NSInteger categoryId;
    NSString * promotionType = @"";
    if (item.promotionType.count > 0) {
        promotionType = item.promotionType[0];
        if (item.promotionType.count > 1) {
            promotionType = @"salesAll";
        }
    }
    if (set.next) {
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        NSInteger count = [set intForColumn:@"count"];
        [_db executeUpdateWithFormat:@"UPDATE t_shoppingcar SET barcode = %@,name = %@,unit = %@,categoryid = %ld,category = %@,subcategory = %@,price = %f,discountype = %@,count = %ld WHERE barcode = %@", item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,promotionType,item.count + count , item.barcode];
    } else {
        categoryId = [CommodityManageTool queryCategoryTypeWithCategoryName:item.category];
        [_db executeUpdateWithFormat:@"INSERT INTO t_shoppingcar (barcode,name,unit,categoryid,category,subcategory,price,discountype,count) VALUES (%@,%@,%@,%ld,%@,%@,%f,%@,%ld);",item.barcode,item.name,item.unit,(long)categoryId,item.category,item.subCategory,item.price,promotionType,item.count];
    }
    [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",1,item.category];
    return true;
}

+ (BOOL)deleteCommodityFromShoppingCar:(CommodityModel *)item
{
    if (item == nil) {
        return false;
    }
    NSString * deleteStr = [NSString stringWithFormat:@"DELETE FROM t_shoppingcar WHERE barcode = '%@'",item.barcode];
    [_db executeUpdate:deleteStr];
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE category = %@",item.category];
    if (set.next) {
    } else {
        [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d WHERE category = %@",0,item.category];
    }
    return true;
}

+ (NSInteger)queryCategoryTypeWithCategoryName:(NSString *)categoryName
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category WHERE category = %@",categoryName];
    NSInteger categoryId = -1;
    while (set.next) {
        categoryId = [set intForColumn:@"categoryid"];
    }
    return categoryId;
}

+ (NSArray *)commoditiesWithCategory:(NSInteger)categoryId
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE categoryid = %ld",categoryId];
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
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

+ (NSArray *)commoditiesWithCategory:(NSInteger)categoryId  promotionType:(NSString *)promotionType
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE categoryid = %ld and discountype = %@",categoryId,promotionType];
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
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

+ (NSArray *)allSalesCommoditiesWithCategory:(NSInteger)categoryId
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_commodity_list WHERE categoryid = %ld and  discountype != %@ ",categoryId,@""];
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
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
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_shoppingcar WHERE categoryid = %ld ",categoryId];
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
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

+ (NSArray *)categories
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category "];
    NSMutableArray * categories = [NSMutableArray array];
    while (set.next) {
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        [categories addObject:commodity];
    }
    return categories;
}

+ (NSArray *)categoriesInShoppingCar
{
    FMResultSet * set = [_db executeQueryWithFormat:@"SELECT * FROM t_category WHERE isExistInShoppingCar = %d",1];
    NSMutableArray * categories = [NSMutableArray array];
    while (set.next) {
        CommodityModel * commodity = [[CommodityModel alloc] init];
        commodity.categoryId = [set intForColumn:@"categoryid"];
        commodity.category = [set stringForColumn:@"category"];
        [categories addObject:commodity];
    }
    return categories;
}

+ (NSArray *)commoditiesInShoppingCar
{
    FMResultSet * set = [_db executeQuery:@"SELECT * FROM t_shoppingcar "];
    NSMutableArray * commodities = [NSMutableArray array];
    while (set.next) {
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

+ (BOOL)clearShoppingCar
{
    BOOL result = [_db executeUpdate:@"DELETE FROM t_shoppingcar"];
    [_db executeUpdateWithFormat:@"update t_category set isExistInShoppingCar = %d ",0];
    return result;
}

@end
