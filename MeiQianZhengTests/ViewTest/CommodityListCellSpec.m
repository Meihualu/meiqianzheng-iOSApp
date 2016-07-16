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
    context(@"when create CommodityListCell ", ^{
        __block CommodityListCell * cell = nil;
        __block UITableView * table = nil;
        beforeEach(^{
            table = [[UITableView alloc] init];
            cell = [CommodityListCell cellWithTableView:table];
        });
        
        afterEach(^{
            table = nil;
            cell = nil;
        });
        
        it(@"should can be init with tableView", ^{
            [[cell shouldNot] beNil];
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
    });
});

SPEC_END
