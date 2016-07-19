//
//  ListTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ListTableViewDataSource.h"
#import "CommodityModel.h"

SPEC_BEGIN(ListTableViewDataSourceSpec)

describe(@"ListTableViewDataSource", ^{
    
    context(@"when creating", ^{
        it(@"should have the class ListTableViewDataSource", ^{
            [[[ListTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            ListTableViewDataSource * dataSource = [[ListTableViewDataSource alloc] init];
            [[dataSource shouldNot] beNil];
        });
    });
    
    context(@"when created", ^{
        __block ListTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[ListTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });

        it(@"should return the number of items in dataSource", ^{
            NSMutableArray * array = [NSMutableArray array];
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
                
            }
            
            dataSource.categories = array;
            NSInteger count = [dataSource numberOfSectionsInTableView:[UITableView mock]];
            [[theValue(count) should] equal:theValue(array.count)];
        });
        
    });
});

SPEC_END
