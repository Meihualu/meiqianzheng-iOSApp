//
//  CommodityDetailViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityDetailViewModel.h"


SPEC_BEGIN(CommodityDetailViewModelSpec)

describe(@"CommodityDetailViewModel", ^{
    context(@"when create", ^{
        __block CommodityDetailViewModel * viewModel = nil;
        beforeEach(^{
            viewModel = [[CommodityDetailViewModel alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
        });
        
        it(@"should have the class CommodityListViewModel", ^{
            [[[CommodityDetailViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            [[viewModel shouldNot] beNil];
        });
        
    });
    
});

SPEC_END
