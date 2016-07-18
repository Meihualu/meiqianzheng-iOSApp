//
//  SettlementViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SettlementViewModel.h"

SPEC_BEGIN(SettlementViewModelSpec)

describe(@"SettlementViewModel", ^{
    context(@"when create", ^{
        __block SettlementViewModel * viewModel = nil;
        beforeEach(^{
            viewModel = [[SettlementViewModel alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
        });
        
        it(@"should have the class SettlementViewModel", ^{
            [[[SettlementViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            [[viewModel shouldNot] beNil];
        });
        
    });
});

SPEC_END
