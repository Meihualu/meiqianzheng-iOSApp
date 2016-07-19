//
//  CommodityDetailCellSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityDetailCell.h"


SPEC_BEGIN(CommodityDetailCellSpec)

describe(@"CommodityDetailCell", ^{
    context(@"when create CommodityListCell", ^{
        it(@"should exist class CommodityDetailCell", ^{
            [[[CommodityDetailCell class] shouldNot] beNil];
        });
    });
});
SPEC_END
