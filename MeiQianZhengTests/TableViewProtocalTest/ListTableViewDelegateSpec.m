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
    context(@"when create", ^{
        __block ListTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[ListTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should have the class ListTableViewDelegate", ^{
            [[[ListTableViewDelegate class] shouldNot] beNil];
        });
        
        it(@"should exist vDelegate", ^{
            [[vDelegate shouldNot] beNil];
        });
    });
    
    context(@"when clicked a cell", ^{
        it(@"should push a CommodityListDetailController", ^{
            
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
});

SPEC_END
