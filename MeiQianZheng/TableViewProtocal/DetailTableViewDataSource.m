//
//  DetailTableViewDataSource.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "DetailTableViewDataSource.h"
#import "CommodityDetailCell.h"

@interface DetailTableViewDataSource()
{
    NSArray * _infoArray;
    NSArray * _contentArray;
}
@end

@implementation DetailTableViewDataSource

-(void)setModel:(CommodityModel *)model
{
    _model = model;
    _infoArray = [NSArray arrayWithObjects:@"名称",@"商品类别",@"商品子类别",@"单价/单位",@"优惠信息",nil];
    NSString * str = [NSString stringWithFormat:@"%.02f元/%@",model.price,model.unit];
    NSString * promotionType = nil;
    if (model.promotionType.count == 0) {
        promotionType = @"暂无优惠";
    }
    /*
      “买二赠一”是指，每当买进两个商品，就可以免费再买一个相同商品。
      “95折”是指，在计算小计的时候按单价的95%计算每个商品。
     */
    promotionType = [model.promotionType[0] isEqualToString:@"BUY_TWO_GET_ONE_FREE"]?@"买二赠一":@"95折";
    _contentArray = [NSArray arrayWithObjects:model.name,model.category,model.subCategory,str,promotionType,nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * detailIdentifier = @"DetailCellIdentifier";
    CommodityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
    if (cell == nil) {
        cell = [[CommodityDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIdentifier];
    }
    cell.info = _infoArray[indexPath.row];
    cell.content = _contentArray[indexPath.row];
    return cell;
}

@end
