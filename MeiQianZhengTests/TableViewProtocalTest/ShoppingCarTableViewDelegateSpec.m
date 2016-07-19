//
//  ShoppingCarTableViewDelegateSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarTableViewDelegate.h"

SPEC_BEGIN(ShoppingCarTableViewDelegateSpec)

describe(@"ShoppingCarTableViewDelegate", ^{
    context(@"when create", ^{
        __block ShoppingCarTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[ShoppingCarTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should have the class ShoppingCarTableViewDelegate", ^{
            [[[ShoppingCarTableViewDelegate class] shouldNot] beNil];
        });
        
        it(@"should exist vDelegate", ^{
            [[vDelegate shouldNot] beNil];
        });
    });
    
    context(@"when show", ^{
        __block ShoppingCarTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[ShoppingCarTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should return 40.0f", ^{
            CGFloat headerHeight =  [vDelegate tableView:[UITableView mock] heightForHeaderInSection:0];
            [[theValue(headerHeight) should] equal:theValue(40.0f)];
        });
        
        it(@"should return 5.0f", ^{
            CGFloat footerHeight = [vDelegate tableView:[UITableView mock] heightForFooterInSection:0];
            [[theValue(footerHeight) should] equal:theValue(5.0f)];
        });
    });
    
});

SPEC_END
