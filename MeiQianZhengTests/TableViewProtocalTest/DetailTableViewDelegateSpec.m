//
//  DetailTableViewDelegateSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DetailTableViewDelegate.h"
const static CGFloat kDetailCellHeight = 40.0f;
const static CGFloat kDetailCellWidth = 100.0f;

SPEC_BEGIN(DetailTableViewDelegateSpec)

describe(@"DetailTableViewDelegate", ^{
    context(@"when create", ^{
        __block DetailTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[DetailTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should have the class DetailTableViewDelegate", ^{
            [[[DetailTableViewDelegate class] shouldNot] beNil];
        });
        
        it(@"should exist vDelegate", ^{
            [[vDelegate shouldNot] beNil];
        });
    });
    /*
     -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
     {
     return kDetailCellHeight;
     }
     
     - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
     {
     return kDetailCellHeight * 2;
     }
     */
    context(@"when table show", ^{
        __block DetailTableViewDelegate * vDelegate = nil;
        beforeEach(^{
            vDelegate = [[DetailTableViewDelegate alloc] init];
        });
        
        afterEach(^{
            vDelegate = nil;
        });
        
        it(@"should return kDetailCellHeight from heightForRowAtIndexPath", ^{
            CGFloat cellHeight = [vDelegate tableView:[UITableView mock] heightForRowAtIndexPath:[NSIndexPath mock]];
            [[theValue(cellHeight) should] equal:theValue(kDetailCellHeight)];
        });
        
        it(@"should return the 2 * kDetailCellHeight from heightForFooterInSection", ^{
            CGFloat footerHeight = [vDelegate tableView:[UITableView mock] heightForFooterInSection:0];
            [[theValue(footerHeight) should] equal:theValue(kDetailCellHeight * 2)];
        });
        
    });
});

SPEC_END
