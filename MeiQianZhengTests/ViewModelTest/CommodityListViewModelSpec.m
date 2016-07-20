//
//  CommodityListViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityListViewModel.h"
#import "CommodityRefreshHeader.h"
#import "CommodityRefreshFooter.h"

SPEC_BEGIN(CommodityListViewModelSpec)

describe(@"CommodityListViewModel", ^{
    
    context(@"when creating", ^{
        it(@"should have the class CommodityListViewModel", ^{
            [[[CommodityListViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            CommodityListViewModel * viewModel = [[CommodityListViewModel alloc] init];
            [[viewModel shouldNot] beNil];
        });
    });
    
    context(@"when created", ^{
        __block CommodityListViewModel * viewModel = nil;
        __block CommodityRefreshFooter * refreshFooter = nil;
        __block CommodityRefreshHeader * refreshHeader = nil;
        beforeEach(^{
            viewModel = [[CommodityListViewModel alloc] init];
            refreshHeader = [[CommodityRefreshHeader alloc] init];
            refreshFooter = [[CommodityRefreshFooter alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
            refreshHeader = nil;
            refreshFooter = nil;
        });
        
        it(@"should have a method that can be get nonil catef=gories and dataSource  after execute headerRefreshRequestWithCallback", ^{
            [viewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
                [[categories shouldNot] beNil];
                [[dataSource shouldNot] beNil];
                [refreshHeader endRefreshing];
            }];
        });
        
        it(@"should have a method that can be get nonil catef=gories and dataSource after execute footerRefreshRequestWithCallback", ^{
            [viewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
                [[categories shouldNot] beNil];
                [[dataSource shouldNot] beNil];
                [refreshFooter endRefreshing];
            }];
        });
        
    });
});

SPEC_END
