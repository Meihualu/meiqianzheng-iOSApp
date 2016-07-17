//
//  CommodityModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityModel.h"


SPEC_BEGIN(CommodityModelSpec)

describe(@"CommodityItemTest", ^{
    context(@"when created", ^{
        __block CommodityModel * item = nil;
        beforeEach(^{
            item = [CommodityModel new];
        });
        
        afterEach(^{
            item = nil;
        });
        
        it(@"should have the class CommdityItem", ^{
            [[[CommodityModel class] shouldNot] beNil];
        });
        
        it(@"should exist", ^{
            [[item shouldNot] beNil];
        });
        
        it(@"should be init by custom init method", ^{
            CommodityModel * item = [[CommodityModel alloc] initWithBarcode:@"mybarcode"
                                                                       name:@"myname"
                                                                       unit:@"myunit"
                                                                   category:@"mycategory"
                                                                 categoryId:1
                                                                subCategory:@"mysubcategory"
                                                                      price:100.0f promotionType:[NSArray array]
                                                                      count:1];
            [[item.barcode should] equal:@"mybarcode"];
            [[item.name should] equal:@"myname"];
            [[item.unit should] equal:@"myunit"];
            [[item.category should] equal:@"mycategory"];
            [[item.subCategory should] equal:@"mysubcategory"];
            [[theValue(item.price) should] equal:theValue(100.0f)];
        });
        
    });
});

SPEC_END
