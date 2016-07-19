//
//  ShoppingCarTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarTableViewDataSource.h"
#import "CommodityModel.h"

SPEC_BEGIN(ShoppingCarTableViewDataSourceSpec)

describe(@"ShoppingCarTableViewDataSource", ^{
    
    context(@"when creating", ^{
        it(@"should have the class ShoppingCarTableViewDataSource", ^{
            [[[ShoppingCarTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            ShoppingCarTableViewDataSource * dataSource = [[ShoppingCarTableViewDataSource alloc] init];
            [[dataSource shouldNot] beNil];
        });
    });
    
    context(@"when created", ^{
        __block ShoppingCarTableViewDataSource * dataSource = nil;
        __block NSMutableArray * categories = nil;
        __block NSArray * dataArray = nil;
        beforeEach(^{
            categories = [NSMutableArray array];
            for (int i = 0; i < 20; i ++) {
                
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                [categories addObject:item];
                
            }
            dataArray = [[NSArray alloc] initWithObjects:
                         [NSArray arrayWithObjects:@"Item1", @"Item2", nil],
                         [NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", nil],
                         [NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", @"Item4", nil],
                         [NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", @"Item4", @"Item5",nil],
                         nil];
            dataSource = [[ShoppingCarTableViewDataSource alloc] init];
            dataSource.categories = categories;
            dataSource.dataSource = dataArray;
        });
        
        afterEach(^{
            dataSource = nil;
            dataArray = nil;
            categories = nil;
        });
        
        it(@"should return the categorys.count from numberOfSectionsInTableView", ^{
            
            NSInteger sections = [dataSource numberOfSectionsInTableView:[UITableView mock]];
            [[theValue(sections) should] equal:theValue(categories.count)];
        });
        
        it(@"should return the dataArray.count from numberOfRowsInSection", ^{
            NSInteger count = [dataSource tableView:[UITableView mock] numberOfRowsInSection:0];
            NSArray * rows = dataArray[0];
            [[theValue(count) should] equal:theValue(rows.count)];
        });
        
        it(@"should return the category from titleForHeaderInSection", ^{
            NSString * category = [dataSource tableView:[UITableView mock] titleForHeaderInSection:0];
            CommodityModel * model = categories[0];
            NSLog(@"category = %@,model.category = %@",category,model.category);
            [[category should] equal:model.category];
        });
    });
});

SPEC_END
