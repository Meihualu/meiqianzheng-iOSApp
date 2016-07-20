//
//  ShoppingCarTableViewDataSource.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarTableViewDataSource.h"
#import "ShoppingCarCell.h"

@implementation ShoppingCarTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rows = _dataSource[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSArray * rows = _dataSource[indexPath.section];
    cell.model = [rows objectAtIndex:indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CommodityModel * model = _categories[section];
    return model.category;
}

#pragma mark 删除按钮的显示
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * rows = _dataSource[indexPath.section];
    CommodityModel * model = [rows objectAtIndex:indexPath.row];
    
    ShoppingCarCell * cell = (ShoppingCarCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [CommodityManageTool deleteCommodityFromShoppingCar:model];
        cell.model.barcode = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDeleteFromShoppingCar object:nil];
    }
}
@end

