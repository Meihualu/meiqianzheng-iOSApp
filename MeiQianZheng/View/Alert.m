//
//  Alert.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "Alert.h"
#import <QuartzCore/QuartzCore.h>
@implementation Alert
+(void)showAlert:(NSString*)message{
    
    CGFloat viewX = (KScreenWidth - 134) / 2;
    CGFloat viewY = (kScreenHeight - 104)/ 2L;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, 134, 104)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [view.layer setCornerRadius:20];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 93, 50)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont boldSystemFontOfSize:15.0f]];
    
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;

    [view addSubview:label];
    label.text=message;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    
    view.alpha=0;
    
    [UIView commitAnimations];
    [view performSelector:@selector(removeFromSuperview) withObject:self afterDelay:1.5];
}
@end
