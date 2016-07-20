//
//  ShoppingCarCell.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "CommodityCountView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ShoppingCarCell()
{
    BOOL                  _checked;
    UIImageView          * _promotionImageView;
    
    UILabel             *  _nameLabel;
    UILabel             *  _priceLabel;
    CommodityCountView    * _countView;
}

@end

@implementation ShoppingCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCustomView];
    }
    return self;
}

- (void)addCustomView {
    _cellHeight = 45.0f;
    CGFloat imageY = (_cellHeight - kMargin * 1.5) / 2;
    _promotionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, imageY, kMargin * 1.5, kMargin * 1.5)];
    _promotionImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:_promotionImageView];
    
    CGFloat width = (KScreenWidth - kMargin * 3) / 3;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, width, _cellHeight)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, width, _cellHeight)];
    _priceLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLabel];
    
    _countView = [[CommodityCountView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 10, 5, width, _cellHeight - 10)];
    _countView.layer.cornerRadius = 5.0f;
    _countView.layer.borderColor = kDefaultColor.CGColor;
    _countView.layer.borderWidth = 0.8f;
    [self.contentView addSubview:_countView];
    
    RAC(_priceLabel,text) = [RACObserve(_countView, count) map:^id(id count) {
        [self setCount];
        [CommodityManageTool addCommodityInShoppingCarAddOneOrReduceOne:_model];
        return [NSString stringWithFormat:@"%.02f元",[self calculatePerCommodityAmount]];
    }];
}

- (void)setModel:(CommodityModel *)model
{
    _model = model;
    [_nameLabel setText:model.name];
    [_priceLabel setText:[NSString stringWithFormat:@"%.02f",model.price * model.count]];
    if ([model.promotionType[0] isEqualToString:@"BuyTwoGetOneFree"]) {
        [_promotionImageView setImage:[UIImage imageNamed:@"21"]];
    } else if ([model.promotionType[0] isEqualToString:@"ZHE_95"]){
        [_promotionImageView setImage:[UIImage imageNamed:@"95"]];
    } else if ([model.promotionType[0] isEqualToString:@"salesAll"]){
        [_promotionImageView setImage:[UIImage imageNamed:@"salesall"]];
    } else {
        [_promotionImageView setImage:[UIImage imageNamed:@"nosale"]];
    }
    _countView.count = _model.count;
}

- (CGFloat)calculatePerCommodityAmount{
    if ([_model.promotionType[0] isEqualToString:@"BuyTwoGetOneFree"]) {
        return [self calculateRealAmountToPay] * _model.price;
    } else if ([_model.promotionType[0] isEqualToString:@"ZHE_95"]){
        return _model.count * 0.95 * _model.price;
    } else if ([_model.promotionType[0] isEqualToString:@"salesAll"]){
        return [self calculateRealAmountToPay] * _model.price;
    } else {
        return _model.count * _model.price;
    }
}

- (NSInteger)calculateRealAmountToPay
{
    NSInteger remainder = _model.count % 3;
    NSInteger divider = _model.count / 3;
    NSInteger  amount  = 0;
    if (divider == 0) {
        amount =  _model.count;
    } else {
        amount = 2 * divider + remainder;
    }
    return amount;
}

-(void)setCount{
    self.model.count = _countView.count;
}

@end
