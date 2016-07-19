//
//  ShoppingCarViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarViewModel.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

SPEC_BEGIN(ShoppingCarViewModelSpec)

describe(@"ShoppingCarViewModel", ^{
    context(@"when create ", ^{
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
        
        it(@"should exist viewModel ", ^{
            [[viewModel shouldNot] beNil];
        });
    });
    
    context(@"when after execute the refresh function", ^{
        __block ShoppingCarViewModel * viewModel = nil;
        __block YiRefreshFooter * refreshFooter = nil;
        __block YiRefreshHeader * refreshHeader = nil;
        beforeEach(^{
            viewModel = [[ShoppingCarViewModel alloc] init];
            refreshHeader = [[YiRefreshHeader alloc] init];
            refreshFooter = [[YiRefreshFooter alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
            refreshHeader = nil;
            refreshFooter = nil;
        });
        
        it(@"should can be get nonil catef=gories and dataSource  after execute headerRefreshRequestWithCallback", ^{
            [viewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
                [[categories shouldNot] beNil];
                [[dataSource shouldNot] beNil];
                [refreshHeader endRefreshing];
            }];
        });
        
        it(@"should can be get nonil catef=gories and dataSource after execute footerRefreshRequestWithCallback", ^{
            [viewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource) {
                [[categories shouldNot] beNil];
                [[dataSource shouldNot] beNil];
                [refreshFooter endRefreshing];
            }];
        });
    
    });
});

SPEC_END
