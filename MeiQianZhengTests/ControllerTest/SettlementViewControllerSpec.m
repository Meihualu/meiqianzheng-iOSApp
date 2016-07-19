//
//  SettlementViewControllerSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SettlementViewController.h"


SPEC_BEGIN(SettlementViewControllerSpec)

describe(@"SettlementViewController", ^{
    context(@"when creating", ^{
        
        it(@"should have the class CommodityDetaiViewController", ^{
            [[[SettlementViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            SettlementViewController * controller = [[SettlementViewController alloc] init];
            [[controller shouldNot] beNil];
        });
        
    });
});

SPEC_END
