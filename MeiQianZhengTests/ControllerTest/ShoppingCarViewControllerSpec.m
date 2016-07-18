//
//  ShoppingCarViewControllerSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarViewController.h"


SPEC_BEGIN(ShoppingCarViewControllerSpec)

describe(@"ShoppingCarViewController", ^{
    
    context(@"when create", ^{
        __block ShoppingCarViewController * controller = nil;
        beforeEach(^{
            controller = [[ShoppingCarViewController alloc] init];
        });
        
        afterEach(^{
            controller = nil;
        });
        
        it(@"should have the class CommodityDetaiViewController", ^{
            [[[ShoppingCarViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            [[controller shouldNot] beNil];
        });
    });
});

SPEC_END
