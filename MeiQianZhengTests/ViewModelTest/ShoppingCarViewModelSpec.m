//
//  ShoppingCarViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarViewModel.h"


SPEC_BEGIN(ShoppingCarViewModelSpec)

describe(@"ShoppingCarViewModel", ^{
    context(@"when create", ^{
        __block ShoppingCarViewModel * viewModel = nil;
        beforeEach(^{
            viewModel = [[ShoppingCarViewModel alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
        });
        
        it(@"should have the class CommodityListViewModel", ^{
            [[[ShoppingCarViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            [[viewModel shouldNot] beNil];
        });
        
    });
});

SPEC_END
