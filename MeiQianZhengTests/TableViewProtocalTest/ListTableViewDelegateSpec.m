//
//  ListTableViewDelegateSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ListTableViewDelegate.h"
#import "CommodityDetaiViewController.h"

SPEC_BEGIN(ListTableViewDelegateSpec)

describe(@"ListTableViewDelegate", ^{
    
    context(@"when creating", ^{
        it(@"should have the class ListTableViewDelegate", ^{
            [[[ListTableViewDelegate class] shouldNot] beNil];
        });
        
        it(@"should exist delegate", ^{
            ListTableViewDelegate * delegate = [[ListTableViewDelegate alloc] init];
            [[delegate shouldNot] beNil];
        });
    });
    
    context(@"when created", ^{
        it(@"should have a method that can push a CommodityListDetailController when click a cell", ^{
            
            ListTableViewDelegate * vDelegate = [[ListTableViewDelegate alloc] init];
            [[vDelegate shouldNot] beNil];
            
            UINavigationController * mocNav = [UINavigationController mock];
            [vDelegate stub:@selector(navController) andReturn:mocNav];
            
            KWCaptureSpy * spy = [mocNav captureArgument:@selector(pushViewController:animated:) atIndex:0];
            [vDelegate tableView:[[UITableView alloc] init] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            CommodityDetaiViewController * vc = spy.argument;
            NSLog(@"vc = %@\n",vc);
            [[vc should] beKindOfClass:[CommodityDetaiViewController class]];
            
        });
    });
    
    context(@"when show", ^{
        __block ListTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[ListTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should have a method that can return the height for header in section default 40.0f", ^{
            CGFloat headerHeight =  [vDelegate tableView:[UITableView mock] heightForHeaderInSection:0];
            [[theValue(headerHeight) should] equal:theValue(40.0f)];
        });
        
        it(@"should have a method that can return the height for header in section default 5.0f", ^{
            CGFloat footerHeight = [vDelegate tableView:[UITableView mock] heightForFooterInSection:0];
            [[theValue(footerHeight) should] equal:theValue(5.0f)];
        });
    });
});

SPEC_END
