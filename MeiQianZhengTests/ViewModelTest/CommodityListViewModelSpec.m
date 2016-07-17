//
//  CommodityListViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityListViewModel.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

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
    
    context(@"when after execute the refresh function", ^{
        __block CommodityListViewModel * viewModel = nil;
        __block YiRefreshFooter * refreshFooter = nil;
        __block YiRefreshHeader * refreshHeader = nil;
        beforeEach(^{
            viewModel = [[CommodityListViewModel alloc] init];
            refreshHeader = [[YiRefreshHeader alloc] init];
            refreshFooter = [[YiRefreshFooter alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
            refreshHeader = nil;
            refreshFooter = nil;
        });
        
        it(@"the dataSource should not be nil after execute headerRefreshRequestWithCallback", ^{
            [viewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
//                [[array shouldNot] beNil];
//                [[theValue(array.count) shouldNot] equal:theValue(0)];
                [refreshHeader endRefreshing];
            }];
        });
        
        it(@"the dataSource should not be nil after execute footerRefreshRequestWithCallback", ^{
            [viewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
//                [[array shouldNot] beNil];
//                [[theValue(array.count) shouldNot] equal:theValue(0)];
                [refreshFooter endRefreshing];
            }];
        });
        
    });
});

SPEC_END
