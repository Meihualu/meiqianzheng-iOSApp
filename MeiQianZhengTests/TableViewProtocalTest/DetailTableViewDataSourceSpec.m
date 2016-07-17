//
//  DetailTableViewDataSourceSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DetailTableViewDataSource.h"


SPEC_BEGIN(DetailTableViewDataSourceSpec)

describe(@"DetailTableViewDataSource", ^{
    context(@"when create", ^{
        __block DetailTableViewDataSource * dataSource = nil;
        beforeEach(^{
            dataSource = [[DetailTableViewDataSource alloc] init];
        });
        
        afterEach(^{
            dataSource = nil;
        });
        
        it(@"should have the class DetailTableViewDataSource", ^{
            [[[DetailTableViewDataSource class] shouldNot] beNil];
        });
        
        it(@"should exist dataSource", ^{
            [[dataSource shouldNot] beNil];
        });
    });
});

SPEC_END
