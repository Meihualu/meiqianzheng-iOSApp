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
    context(@"when create", ^{
        __block CommodityListViewController * controller = nil;
        beforeEach(^{
            controller = [[CommodityListViewController alloc] init];
        });
        
        afterEach(^{
            controller = nil;
        });
        
        it(@"should have the class CommodityListViewController", ^{
            [[[CommodityListViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            [[controller shouldNot] beNil];
        });
    });
    
    context(@"", ^{
        
    });
    
});

SPEC_END
