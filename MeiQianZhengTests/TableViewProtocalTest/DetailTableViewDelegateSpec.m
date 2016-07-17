//
//  DetailTableViewDelegateSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DetailTableViewDelegate.h"


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
});

SPEC_END
