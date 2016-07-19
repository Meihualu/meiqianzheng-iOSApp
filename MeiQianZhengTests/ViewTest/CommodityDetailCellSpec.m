//
//  CommodityDetailCellSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CommodityDetailCell.h"


SPEC_BEGIN(CommodityDetailCellSpec)

describe(@"CommodityDetailCell", ^{
    context(@"when creating ", ^{
        it(@"should exist class CommodityDetailCell", ^{
            [[[CommodityDetailCell class] shouldNot] beNil];
        });
        
        it(@"can be init", ^{
            CommodityDetailCell * cell = [[CommodityDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
            [[cell shouldNot] beNil];
        });
    });
    
    context(@"when be created", ^{
        __block CommodityDetailCell * cell = nil;
        beforeEach(^{
            cell = [[CommodityDetailCell alloc] init];
        });
        
        afterEach(^{
            cell = nil;
        });
        
        it(@"should can be setted info", ^{
            NSString * str = @"info";
            [cell setInfo:str];
            [[cell.info should] equal:str];
        });
        
        it(@"should can be setted content", ^{
           NSString * content = @"content";
            [cell setContent:content];
            [[cell.content should] equal:content];
        });
        
    });
});
SPEC_END
