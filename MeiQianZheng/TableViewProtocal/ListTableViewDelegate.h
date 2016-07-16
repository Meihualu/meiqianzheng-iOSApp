//
//  TableViewDelegate.h
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) UINavigationController * navController;

@end
