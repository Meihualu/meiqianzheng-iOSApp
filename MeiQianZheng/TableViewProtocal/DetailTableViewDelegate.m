//
//  DetailTableViewDelegate.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "DetailTableViewDelegate.h"

@implementation DetailTableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDetailCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(void)setModel:(CommodityModel *)model
{
    _model = model;
}

/*
 “买二赠一”是指，每当买进两个商品，就可以免费再买一个相同商品。
 
 “95折”是指，在计算小计的时候按单价的95%计算每个商品。
 
 每一种优惠都详细标记了哪些条形码对应的商品可以享受此优惠。
 
 店员设置，当“95折”和“买二赠一”发生冲突的时候，也就是一款商品既符合享受“买二赠一”优惠的条件，又符合享受“95折”优惠的条件时，只享受“买二赠一”优惠。
 */
-(CGRect)labelFrameWithContent:(NSString *)content{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize queLabelSize = [content boundingRectWithSize:CGSizeMake(KScreenWidth - 20, 999.0f)
                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             attributes:attributes context:nil].size;
    
    CGRect frame = CGRectMake(10, 0, KScreenWidth - 20, queLabelSize.height + 20);
    return frame;
    
}

@end
