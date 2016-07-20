//
//  ShoppingCarViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarViewModel.h"
#import "CommodityRefreshHeader.h"
#import "CommodityRefreshFooter.h"

SPEC_BEGIN(ShoppingCarViewModelSpec)

describe(@"ShoppingCarViewModel", ^{
    
    context(@"when creating", ^{
        it(@"should have the class ShoppingCarViewModel", ^{
            [[[ShoppingCarViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            ShoppingCarViewModel * viewModel = [[ShoppingCarViewModel alloc] init];
            [[viewModel shouldNot] beNil];
        });
    });
    
    context(@"when created", ^{
        __block ShoppingCarViewModel * viewModel = nil;
        __block CommodityRefreshFooter * refreshFooter = nil;
        __block CommodityRefreshHeader * refreshHeader = nil;
        beforeEach(^{
            viewModel = [[ShoppingCarViewModel alloc] init];
            refreshHeader = [[CommodityRefreshHeader alloc] init];
            refreshFooter = [[CommodityRefreshFooter alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
            refreshHeader = nil;
            refreshFooter = nil;
        });
        
        it(@"should have a method that  can be get nonil categories and dataSource  after execute headerRefreshRequestWithCallback", ^{
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
