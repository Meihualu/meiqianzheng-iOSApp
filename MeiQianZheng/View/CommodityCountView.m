//
//  CommodityCountView.m
//  ThoughtWorks
//
//  Created by msn on 16/5/26.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityCountView.h"
const CGFloat width = 30.0f;

@interface CommodityCountView()
{
    UIButton * _addButton;
    UIButton * _subButton;
    UILabel  * _countField;
}
@end

@implementation CommodityCountView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        [self addCustomView];
    }
    return self;
}

- (void)addCustomView {
    
    _subButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    [_subButton setTitle:@"-" forState:UIControlStateNormal];
    [_subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_subButton addTarget:self action:@selector(subCount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subButton];
    
    _countField = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, width, width)];
    [_countField setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_countField setText:@"0"];
    [_countField setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_countField];
    
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(width * 2, 0, width, width)];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
}

- (void)addCount:(UIButton *)button
{
    NSInteger count = [_countField.text integerValue];
    count++;
    [_countField setText:[NSString stringWithFormat:@"%zd",count]];
    self.count = count;
}

- (void)subCount:(UIButton *)button
{
    NSInteger count = [_countField.text integerValue];
    if (count > 0) {
        count --;
    }
    [_countField setText:[NSString stringWithFormat:@"%zd",count]];
    self.count = count;
}

@end
