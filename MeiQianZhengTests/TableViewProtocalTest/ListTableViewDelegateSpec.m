//
//  ListTableViewDelegateSpec.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright 2016年 ZYL. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ListTableViewDelegate.h"


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
});

SPEC_END
