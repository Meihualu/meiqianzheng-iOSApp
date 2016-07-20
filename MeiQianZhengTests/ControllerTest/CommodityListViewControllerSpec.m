//
//  CommodityListViewControllerSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityListViewController.h"


SPEC_BEGIN(CommodityListViewControllerSpec)

describe(@"CommodityListViewController", ^{
    context(@"when creating", ^{
        
        it(@"should have the class CommodityListViewController", ^{
            [[[CommodityListViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            CommodityListViewController * controller = [[CommodityListViewController alloc] init];
            [[controller shouldNot] beNil];
        });
    });
    
});

SPEC_END
