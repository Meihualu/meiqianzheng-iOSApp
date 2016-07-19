//
//  SettlementViewModelSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/18.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SettlementViewModel.h"
#import "CommodityModel.h"

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
    
    context(@"when used", ^{
        
        __block SettlementViewModel * viewModel = nil;
        beforeEach(^{
            viewModel = [[SettlementViewModel alloc] init];
        });
        
        afterEach(^{
            viewModel = nil;
        });
        
        it(@"should can scan commodity and put them into scanInfoArray", ^{
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < 20; i ++) {
                
                CommodityModel * item = [[CommodityModel alloc] initWithBarcode:[NSString stringWithFormat:@"mybarcode%zd",i]
                                                                           name:[NSString stringWithFormat:@"myname%zd",i]
                                                                           unit:[NSString stringWithFormat:@"myunit%zd",i]
                                                                       category:[NSString stringWithFormat:@"mycategory%zd",i]
                                                                     categoryId:i
                                                                    subCategory:[NSString stringWithFormat:@"mysubcategory%zd",i]
                                                                          price:100.0f promotionType: [NSArray arrayWithObjects:@"man3mian1", @"ceshiceshi", nil]
                                                                          count:i];
                [array addObject:item];
                
            }
            NSMutableArray * marray = [NSMutableArray array];
            [marray addObject:array];
            viewModel.shoppingcarCommodities = marray;
            [viewModel scanCommoditiyBarcode];
            NSLog(@"viewModel.scanInfoArray.count = %zd\n",viewModel.scanInfoArray.count);
            [[theValue(viewModel.scanInfoArray.count) should] equal:theValue(array.count + 2)];
            
        });
        
        it(@"should can append text to the given textview", ^{
            UITextView * textView = [[UITextView alloc] init];
            textView.text = @"hello";
            [viewModel appendContent:@"world" textView:textView];
            NSLog(@"textView.text = %@\n",textView.text);
            [[textView.text should] equal:@"helloworld\n"];
        });
        
        
        
    });
});

SPEC_END
