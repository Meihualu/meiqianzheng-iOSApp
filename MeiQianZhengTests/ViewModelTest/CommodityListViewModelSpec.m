//
//  CommodityListViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityListViewModel.h"


SPEC_BEGIN(CommodityListViewModelSpec)

describe(@"CommodityListViewModel", ^{
    context(@"when create", ^{
        __block CommodityListViewModel * viewModel = nil;
        beforeEach(^{
            viewModel = [[CommodityListViewModel alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
        });
        
        it(@"should have the class CommodityListViewModel", ^{
            [[[CommodityListViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            [[viewModel shouldNot] beNil];
        });
    });
});

SPEC_END
