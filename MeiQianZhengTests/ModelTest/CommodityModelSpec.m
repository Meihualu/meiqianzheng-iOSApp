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

describe(@"CommodityModel", ^{
    context(@"when create", ^{
        __block CommodityModel * model = nil;
        beforeEach(^{
            model = [[CommodityModel alloc] init];
        });
        
        afterEach(^{
            model = nil;
        });
        
        it(@"should have the class CommodityModel", ^{
            [[[CommodityModel class] shouldNot] beNil];
        });
        
        it(@"should exist model", ^{
            [[model shouldNot] beNil];
        });
    });
});

SPEC_END
