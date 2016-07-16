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
    context(@"when create", ^{
        __block CommodityListCell * listCell = nil;
        beforeEach(^{
            listCell = [[CommodityListCell alloc] init];
        });
        
        afterEach(^{
            listCell = nil;
        });
        
        it(@"should have the class CommodityListCell", ^{
            [[[CommodityListCell class] shouldNot] beNil];
        });
        
        it(@"should exist listCell", ^{
            [[listCell shouldNot] beNil];
        });
    });
});

SPEC_END
