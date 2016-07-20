//
//  CommodityManageToolSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityManageTool.h"


SPEC_BEGIN(CommodityManageToolSpec)

describe(@"CommodityManageTool", ^{
    context(@"when creating", ^{
        it(@"should have the class CommodityManageTool", ^{
            [[[CommodityManageTool class] shouldNot] beNil];
        });
        
    });
    
    context(@"when created", ^{
        
        __block CommodityModel * model = nil;
        beforeEach(^{
            model = [[CommodityModel alloc] initWithBarcode:@"mybarcode" name:@"myname"
                                                       unit:@"myunit"
                                                   category:@"mycategory"
                                                 categoryId:1
                                                subCategory:@"mysubcategory"
                                                      price:100.0f
                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                      count:3];
        });
        
        afterEach(^{
            model = nil;
        });
        
        it(@"should exist the database file shops.sqlite", ^{
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            [[theValue([fileMgr fileExistsAtPath:path]) should] beTrue];
        });
        
        /**
         *  向商品列表中添加一个商品
         *
         *  @param item 商品
         */
        //        + (void)addCommodityInList:(CommodityModel *)item;
        it(@"should can correct add CommodityModel in commodity list", ^{
            [CommodityManageTool addCommodityInList:model];
    
        });
        /**
         *  向购物车中添加一个商品
         *
         *  @param item 商品
         */
        //        + (void)addCommodityInShoppingCar:(CommodityModel *)item;
        it(@"", ^{
            
        });
        /**
         *  获得所有的商品种类
         *
         *  @return 商品种类
         */
//        + (NSArray *)categories;
        it(@"", ^{
            
        });
        
        /**
         *  获取购物车中的商品的种类
         *
         *  @return 商品种类
         */
//        + (NSArray *)categoriesInShoppingCar;
        it(@"", ^{
            
        });
        /**
         *  根据商品种类Id获取商品
         *
         *  @param categoryId 目标商品的种类Id
         *
         *  @return 商品列表
         */
//        + (NSArray *)commoditiesWithCategory:(NSInteger )categoryId;
        it(@"", ^{
            
        });
        /**
         *  根据商品种类Id和优惠类型获取商品列表
         *
         *  @param categoryId    商品种类Id
         *  @param promotionType 优惠类型
         *
         *  @return 商品列表
         */
//        + (NSArray *)commoditiesWithCategory:(NSInteger)categoryId  promotionType:(NSString *)promotionType;
        it(@"", ^{
            
        });
        /**
         *  获取所有的优惠商品信息
         *
         *  @param categoryId 商品种类Id
         *
         *  @return 商品列表
         */
//        + (NSArray *)allSalesCommoditiesWithCategory:(NSInteger)categoryId;
        it(@"", ^{
            
        });
        /**
         *  根据种类Id获取购物车中的商品列表
         *
         *  @param categoryId 商品种类Id
         *
         *  @return 商品列表
         */
//        + (NSArray *)commoditiesInShoppingCarWithCategory:(NSInteger)categoryId;
        it(@"", ^{
            
        });
        /**
         *  获取购物车中的所有商品
         *
         *  @return 商品列表
         */
//        + (NSArray *)commoditiesInShoppingCar;
        it(@"", ^{
            
        });
                /**
         *  修改购物车中商品的数量：增加一个或减少一个
         *
         *  @param item 商品
         */
//        + (void)addCommodityInShoppingCarAddOneOrReduceOne:(CommodityModel *)item ;
        it(@"", ^{
            
        });
        /**
         *  从购物车中删除一个商品
         *
         *  @param item 要删除的商品
         */
//        + (void)deleteCommodityFromShoppingCar:(CommodityModel *)item;
        it(@"", ^{
            
        });
        /**
         *  清空购物车
         */
//        + (void)clearShoppingCar;
        it(@"", ^{
            
        });
    });
});

















SPEC_END
