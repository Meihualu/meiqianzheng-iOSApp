//
//  TableViewDelegate.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ListTableViewDelegate.h"

@implementation ListTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommodityDetaiViewController * detailController = [[CommodityDetaiViewController alloc] initWithCommodityModel:_array[indexPath.row]];
    [self.navController pushViewController:detailController animated:YES];
}

@end
