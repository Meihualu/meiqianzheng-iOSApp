//
//  ListTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ListTableViewDataSource.h"


SPEC_BEGIN(ListTableViewDataSourceSpec)

describe(@"ListTableViewDataSource", ^{
    context(@"when create", ^{
        __block ListTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[ListTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });
        
        it(@"should have the class ListTableViewDataSource", ^{
            [[[ListTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            [[dataSource shouldNot] beNil];
        });
    });
});

SPEC_END
