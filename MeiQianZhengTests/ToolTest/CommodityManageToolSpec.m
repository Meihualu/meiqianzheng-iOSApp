//
//  CommodityManageToolSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityManageTool.h"
#import "FMDB.h"

SPEC_BEGIN(CommodityManageToolSpec)

describe(@"CommodityManageTool", ^{
    context(@"when creating", ^{
        it(@"should have the class CommodityManageTool", ^{
            [[[CommodityManageTool class] shouldNot] beNil];
        });
        
    });
    
    context(@"when created", ^{
        static FMDatabase * _fmdb;
        __block CommodityModel * model = nil;
        beforeEach(^{
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
            _fmdb = [FMDatabase databaseWithPath:path];
            [_fmdb open];
            model = [[CommodityModel alloc] initWithBarcode:@"mybarcode" name:@"myname"
                                                       unit:@"myunit"
                                                   category:@"mycategory0"
                                                 categoryId:1
                                                subCategory:@"mysubcategory"
                                                      price:100.0f
                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", nil]
                                                      count:3];
        });
        
        afterEach(^{
            model = nil;
            [_fmdb close];
        });
        
        it(@"should exist the database file shops.sqlite", ^{
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            [[theValue([fileMgr fileExistsAtPath:path]) should] beTrue];
        });
        
        it(@"should have a method that can correct add a CommodityModel in commodity list", ^{
            BOOL result = [CommodityManageTool addCommodityInList:model];
            FMResultSet * set = [_fmdb executeQueryWithFormat:@"select * from t_commodity_list where barcode = %@\n",model.barcode];
            [[theValue(result) should] beTrue];
            [[theValue(set.next) should] beTrue];
        });
        
        it(@"should can deal a nil parameters when add in list when execute addCommodityInList", ^{
            BOOL result = [CommodityManageTool addCommodityInList:nil];
            [[theValue(result) should] beFalse];
        });
        

        it(@"should have a method that can correct add CommodityModel in commodity list", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:model];
            FMResultSet * set = [_fmdb executeQueryWithFormat:@"select * from t_shoppingcar where barcode = %@\n",model.barcode];
            [[theValue(result) should] beTrue];
            [[theValue(set.next) should] beTrue];
        });
        
        it(@"should can deal a nil parameters when add to shoppingcar when execute addCommodityInShoppingCar", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:nil];
            [[theValue(result) should] beFalse];
        });
        
        it(@"should have a method that can get all models in shoppingcar", ^{
            
            NSMutableArray * array = [NSMutableArray array];
            BOOL result = false;
            for (int i = 0; i < 20; i ++) {
                
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                [array addObject:item];
                result = [CommodityManageTool addCommodityInList:item];
                [[theValue(result) should] beTrue];
            }
            
            NSArray * categories = [CommodityManageTool categories];
            NSLog(@"categories.count = %zd\n",categories.count);
            NSLog(@"array.count = %zd\n",array.count);
            [[theValue(categories.count) should] equal:theValue(array.count)];
            
        });
        
        it(@"should have a function to return all categories in shopping car", ^{
            NSMutableArray * array = [NSMutableArray array];
            BOOL result = false;
            for (int i = 1; i < 3; i ++) {
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                [array addObject:item];
                result = [CommodityManageTool addCommodityInShoppingCar:item];
                [[theValue(result) should] beTrue];
            }
            NSArray * categories = [CommodityManageTool commoditiesInShoppingCar];
            NSLog(@"categories = %@\n",categories);
            NSLog(@"categories.count = %zd,array.count = %zd\n",categories.count,array.count);
            [[theValue(categories.count) should] equal:theValue(array.count + 1)];

        });

        it(@"should have a meothed that can return commodities that have same categoryId through the categoryId ", ^{
            BOOL result = false;
            CommodityModel * item = [[CommodityModel alloc] initWithBarcode:@"mybarcodeitem" name:@"myname"
                                                                       unit:@"myunit"
                                                                   category:@"mycategory0"
                                                                 categoryId:1
                                                                subCategory:@"mysubcategory"
                                                                      price:100.0f
                                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                      count:3];
            
            result = [CommodityManageTool addCommodityInList:item];
            [[theValue(result) should] beTrue];
            result = [CommodityManageTool addCommodityInList:model];
            [[theValue(result) should] beTrue];
            
            NSArray * commodities = [CommodityManageTool commoditiesWithCategory:1];
            NSLog(@"commodities = %@\n",commodities);
            [[theValue(commodities.count) should] equal:theValue(3)];
        });

        it(@"should have a function that can return commodities through categoryId and promotionType", ^{
            BOOL result = false;
            CommodityModel * item = [[CommodityModel alloc] initWithBarcode:@"mybarcodeitem" name:@"myname"
                                                                       unit:@"myunit"
                                                                   category:@"mycategory0"
                                                                 categoryId:1
                                                                subCategory:@"mysubcategory"
                                                                      price:100.0f
                                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", nil]
                                                                      count:3];
            
            result = [CommodityManageTool addCommodityInList:item];
            [[theValue(result) should] beTrue];
            result = [CommodityManageTool addCommodityInList:model];
            [[theValue(result) should] beTrue];
            
            NSArray * commodities = [CommodityManageTool commoditiesWithCategory:1 promotionType:@"man3mian1"];
            NSLog(@"commodities = %@\n",commodities);
            [[theValue(commodities.count) should] equal:theValue(2)];
        });

        it(@"should have a method that can return all commodities through categoryId", ^{
            BOOL result = false;
            CommodityModel * item = [[CommodityModel alloc] initWithBarcode:@"mybarcodeitem" name:@"myname"
                                                                       unit:@"myunit"
                                                                   category:@"mycategory0"
                                                                 categoryId:1
                                                                subCategory:@"mysubcategory"
                                                                      price:100.0f
                                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", nil]
                                                                      count:3];
            
            result = [CommodityManageTool addCommodityInShoppingCar:item];
            [[theValue(result) should] beTrue];
            
            result = [CommodityManageTool addCommodityInShoppingCar:model];
            [[theValue(result) should] beTrue];
            
            NSArray * commodities = [CommodityManageTool commoditiesInShoppingCarWithCategory:1];
            [[theValue(commodities.count) should] equal:theValue(2)];
        });

        it(@"should have a method that can get all models in shoppingcar", ^{
            NSMutableArray * array = [NSMutableArray array];
            BOOL result = false;
            for (int i = 0; i < 20; i ++) {
                
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                [array addObject:item];
                result = [CommodityManageTool addCommodityInShoppingCar:item];
                [[theValue(result) should] beTrue];
            }
            
            NSArray * categories = [CommodityManageTool commoditiesInShoppingCar];
            NSLog(@"categories.count = %zd,array.count = %zd\n",categories.count,array.count);
            [[theValue(categories.count) should] equal:theValue(array.count+2)];

        });
        
        it(@"should have a method that can add a model to make the count property of this model in shoppingcar equal to the added model", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCarAddOneOrReduceOne:model];
            [[theValue(result) should] beTrue];
            
            FMResultSet * set = [_fmdb  executeQueryWithFormat:@"select * from t_shoppingcar where barcode = %@",model.barcode];
            if (set.next)
            {
                NSInteger count  = [set intForColumn:@"count"];
                [[theValue(count) should] equal:theValue(model.count)];
            }
        });

        it(@"should can deal a nil parameters when execute addCommodityInShoppingCarAddOneOrReduceOne", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCarAddOneOrReduceOne:nil];
            [[theValue(result) should] beFalse];
        });

        it(@"should can deal this condition when the primary key is nil when execute addCommodityInShoppingCarAddOneOrReduceOne", ^{
            model.barcode = nil;
            BOOL result = [CommodityManageTool addCommodityInShoppingCarAddOneOrReduceOne:model];
            [[theValue(result) should] beFalse];
        });
        
        
        it(@"should have e method that can delete a item form shoppingcar", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:model];
            [[theValue(result) should] beTrue];
            
            result = [CommodityManageTool deleteCommodityFromShoppingCar:model];
            [[theValue(result) should] beTrue];
            
        });
        
        it(@"should can deal a nil parameters when execute deleteCommodityFromShoppingCar", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:nil];
            [[theValue(result) should] beFalse];
        });
        
        it(@"should can deal this condition that the primary key is nil  when execute deleteCommodityFromShoppingCar", ^{
            model.barcode = nil;
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:model];
            [[theValue(result) should] beFalse];
        });
        
        
        
        it(@"should have a method that can clear the shopping car", ^{
            BOOL result = [CommodityManageTool addCommodityInShoppingCar:model];
            [[theValue(result) should] beTrue];
            
            result = [CommodityManageTool clearShoppingCar];
            [[theValue(result) should] beTrue];
        });
    });
});

















SPEC_END
