//
//  ShoppingCarTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ShoppingCarTableViewDataSource.h"


SPEC_BEGIN(ShoppingCarTableViewDataSourceSpec)

describe(@"ShoppingCarTableViewDataSource", ^{
    context(@"when create", ^{
        __block ShoppingCarTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[ShoppingCarTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });
        
        it(@"should have the class ShoppingCarTableViewDataSource", ^{
            [[[ShoppingCarTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            [[dataSource shouldNot] beNil];
        });
    });

});

SPEC_END
