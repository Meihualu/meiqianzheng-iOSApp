//
//  TableViewDataSource.h
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NSArray * categories;

@end
