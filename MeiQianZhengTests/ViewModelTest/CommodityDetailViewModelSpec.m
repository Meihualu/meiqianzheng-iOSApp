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
    
    context(@"when creating", ^{
        it(@"should have the class CommodityDetailViewModel", ^{
            [[[CommodityDetailViewModel class] shouldNot] beNil];
        });
        
        it(@"should exist viewModel", ^{
            CommodityDetailViewModel * viewModel = [[CommodityDetailViewModel alloc] init];
            [[viewModel shouldNot] beNil];
        });
    });
    
    
    context(@"when created", ^{
        __block CommodityDetailViewModel * viewModel = nil;
        __block CommodityModel * model = nil;
        beforeEach(^{
            model = [[CommodityModel alloc] initWithBarcode:@"mybarcode" name:@"myname"
                                                                        unit:@"myunit"
                                                                    category:@"mycategory"
                                                                  categoryId:1
                                                                 subCategory:@"mysubcategory"
                                                                       price:100.0f
                                                               promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                       count:3];
            viewModel = [[CommodityDetailViewModel alloc] init];
            viewModel.model = model;
        });
        
        afterEach(^{
            viewModel = nil;
            model = nil;
        });
        
        it(@"should correct deal the text change", ^{
            NSString * text = @"10";
            [viewModel dealTextFieldTextChangeWithText:text];
            NSLog(@"viewModel.model.count = %zd\n",viewModel.model.count);
            [[theValue(viewModel.model.count) should] equal:theValue([text integerValue])];
        });
        
        it(@"should correct deal the add count operation", ^{
            NSInteger count = viewModel.model.count;
            [viewModel addNumberOfItem];
            [[theValue(viewModel.model.count) should] equal:theValue(count + 1)];
        });
        
        it(@"should not execute the reduce count operation ,when the count of model == 0", ^{
            NSInteger count = viewModel.model.count;
            viewModel.model.count = 0;
            [viewModel reduceNumberOfItem];
            [[theValue(viewModel.model.count) should] equal:theValue(0)];
            viewModel.model.count = count;
        });
        
        it(@"should correct deal the reduce count operation", ^{
            NSInteger count = viewModel.model.count;
            [viewModel reduceNumberOfItem];
            [[theValue(viewModel.model.count) should] equal:theValue(count - 1)];
        });
        
        it(@"should return '请选择商品的数量' when the count of model == 0", ^{
            NSInteger count = viewModel.model.count;
            viewModel.model.count = 0;
            NSString * prompt = [viewModel getPrompt];
            NSLog(@"prompt = %@\n",prompt);
            [[prompt should] equal:@"请选择商品的数量"];
            viewModel.model.count = count;
        });
        
        it(@"should return the name and number that will be added to shoppingcar", ^{
            NSString * prompt = [viewModel getPrompt];
            NSString * info = [NSString stringWithFormat:@"已成功将商品添加进购物车：商品名：%@ 数量：%zd",viewModel.model.name,viewModel.model.count];
            [[prompt should] equal:info];
        });
    });
    
});

SPEC_END
