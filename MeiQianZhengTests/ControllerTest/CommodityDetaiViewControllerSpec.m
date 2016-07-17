//
//  CommodityDetaiViewControllerSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityDetaiViewController.h"


SPEC_BEGIN(CommodityDetaiViewControllerSpec)

describe(@"CommodityDetaiViewController", ^{
    context(@"when create", ^{
        __block CommodityDetaiViewController * controller = nil;
        beforeEach(^{
            controller = [[CommodityDetaiViewController alloc] init];
        });
        
        afterEach(^{
            controller = nil;
        });
        
        it(@"should have the class CommodityDetaiViewController", ^{
            [[[CommodityDetaiViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            [[controller shouldNot] beNil];
        });
    });
});

SPEC_END
