//
//  ShoppingCarCellSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarCell.h"


SPEC_BEGIN(ShoppingCarCellSpec)

describe(@"ShoppingCarCell", ^{
    
    context(@"when creating", ^{
        it(@"should have the class CommodityListCell", ^{
            [[[ShoppingCarCell class] shouldNot] beNil];
        });
        
        it(@"should can be init with tableView", ^{
            ShoppingCarCell * cell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
            [[cell shouldNot] beNil];
        });
        
    });
    
    context(@"when created", ^{
        __block ShoppingCarCell * cell = nil;
        __block UITableView * table = nil;
        beforeEach(^{
            table = [[UITableView alloc] init];
            cell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
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
});
SPEC_END
