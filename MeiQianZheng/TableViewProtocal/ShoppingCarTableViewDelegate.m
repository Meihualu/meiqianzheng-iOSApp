//
//  ShoppingCarTableViewDelegate.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarTableViewDelegate.h"
#import "CommodityDetaiViewController.h"

@implementation ShoppingCarTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSArray * items = _array[indexPath.section];
//    CommodityDetaiViewController * detailController = [[CommodityDetaiViewController alloc] initWithCommodityModel:items[indexPath.row]];
//    [self.navController pushViewController:detailController animated:YES];
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