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
});

SPEC_END
