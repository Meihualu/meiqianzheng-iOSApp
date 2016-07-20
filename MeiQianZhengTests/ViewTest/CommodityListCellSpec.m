//
//  CommodityListCellSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityListCell.h"

SPEC_BEGIN(CommodityListCellSpec)

describe(@"CommodityListCell", ^{
    context(@"when creating", ^{
        it(@"should have the class CommodityListCell", ^{
            [[[CommodityListCell class] shouldNot] beNil];
        });
        
        it(@"should can be init with tableView", ^{
            CommodityListCell * cell = [[CommodityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
            [[cell shouldNot] beNil];
        });
        
    });
    
    context(@"when created", ^{
        __block CommodityListCell * cell = nil;
        __block UITableView * table = nil;
        beforeEach(^{
            table = [[UITableView alloc] init];
            cell = [[CommodityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
        });
        
        afterEach(^{
            table = nil;
            cell = nil;
        });
        
        it(@"the cellHeight should be init ", ^{
            [[theValue(cell.cellHeight) should] equal:theValue(45.0f)];
        });
        
        it(@"should can be set the model", ^{
            CommodityModel * model = [[CommodityModel alloc] init];
            model.name = @"测试";
            [cell setModel:model];
            [[cell.model.name should] equal:@"测试"];
        });
        
        it(@"should have a default cellHeight,temporary set 45.0f", ^{
            [[theValue(cell.cellHeight) should] equal:theValue(45.0f)];
        });
        
        it(@"should can be set model", ^{
            cell.model = [[CommodityModel alloc] init];
            [[cell.model shouldNot] beNil];
        });
        
    });
    
    context(@"when have setted model", ^{
        it(@"should can be corrent set the promotion symbol image", ^{
           CommodityModel * model = [[CommodityModel alloc] initWithBarcode:@"mybarcode" name:@"myname"
                                                       unit:@"myunit"
                                                   category:@"mycategory"
                                                 categoryId:1
                                                subCategory:@"mysubcategory"
                                                      price:100.0f
                                              promotionType: [NSArray arrayWithObjects:@"BUY_TWO_GET_ONE_FREE", nil]
                                                      count:3];
            
        CommodityListCell *  cell = [[CommodityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
            [cell setModel:model];
        });
    });
});

SPEC_END
