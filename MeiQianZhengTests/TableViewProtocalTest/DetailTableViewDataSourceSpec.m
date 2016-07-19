//
//  DetailTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DetailTableViewDataSource.h"


SPEC_BEGIN(DetailTableViewDataSourceSpec)

describe(@"DetailTableViewDataSource", ^{
    context(@"when create", ^{
        __block DetailTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[DetailTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });
        
        it(@"should have the class DetailTableViewDataSource", ^{
            [[[DetailTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            [[dataSource shouldNot] beNil];
        });
        
        /*
         
         -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
         return 1;
         }
         
         -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
         {
         return _infoArray.count;
         }
         */
    });
    
    context(@"when table show", ^{
        __block DetailTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[DetailTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });
        
        it(@"should have one section", ^{
            NSInteger sections = [dataSource numberOfSectionsInTableView:[UITableView mock]];
            [[theValue(sections) should] equal:theValue(1)];
        });
        
        it(@"the numberOfRowsInSection should equal the info array initilized by commodity", ^{
            CommodityModel * model = [[CommodityModel alloc] initWithBarcode:@"mybarcode"
name:@"myname"
                                                                       unit:@"myunit"
                                                                   category:@"mycategory"
                                                                 categoryId:1
                                                                subCategory:@"mysubcategory"
                                                                      price:100.0f
                                                              promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                      count:3];
            
            
            NSString * str = [NSString stringWithFormat:@"%.02f元/%@",model.price,model.unit];
            NSString * promotionType = @"买二送一 95折";
            
            NSArray * contentArray = [NSArray arrayWithObjects:model.name,model.category,model.subCategory,str,promotionType,nil];
            dataSource.model = model;
            NSInteger infoCount = [dataSource tableView:[UITableView mock] numberOfRowsInSection:0];
            NSLog(@"infoCount = %zd\n",infoCount);
            
            [[theValue(infoCount) should] equal:theValue(contentArray.count)];
            
        });
    });
});

SPEC_END
