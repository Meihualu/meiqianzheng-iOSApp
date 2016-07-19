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
    
    context(@"when creating", ^{
        
        it(@"should have the class CommodityDetaiViewController", ^{
            [[[ShoppingCarViewController class] shouldNot] beNil];
        });
        
        it(@"should exist controller", ^{
            ShoppingCarViewController * controller = [[ShoppingCarViewController alloc] init];
            [[controller shouldNot] beNil];
        });
        
    });
});

SPEC_END
