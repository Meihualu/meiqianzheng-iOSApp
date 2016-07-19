//
//  TableViewDelegate.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ListTableViewDelegate.h"
#import "CommodityModel.h"
@implementation ListTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray * items = _array[indexPath.section];
    CommodityDetaiViewController * detailController = [[CommodityDetaiViewController alloc] initWithCommodityModel:items[indexPath.row]];
    [self.navController pushViewController:detailController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

@end
