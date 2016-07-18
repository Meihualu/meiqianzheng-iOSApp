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
    _countView.layer.borderWidth = 2.0f;
    [self.contentView addSubview:_countView];
    
    RAC(_priceLabel,text) = [RACObserve(_countView, count) map:^id(id count) {
        return [NSString stringWithFormat:@"%.02f",[count integerValue] * _model.price];
    }];
}

- (void)setModel:(CommodityModel *)model
{
    _model = model;
    [_nameLabel setText:model.name];
    [_priceLabel setText:[NSString stringWithFormat:@"%.02f",model.price * model.count]];
    if (model.promotionType.count > 0) {
        _promotionImageView.backgroundColor = [UIColor redColor];
    } else {
        _promotionImageView.backgroundColor = [UIColor whiteColor];
    }
    _countView.count = _model.count;
}

- (void)calculatePerCommodityAmount{
    if ([_model.promotionType[0] isEqualToString:@""]) {
        
    } else if([_model.promotionType[0] isEqualToString:@""]) {
    
    } else {
      
    }
}

-(void)setCount{
    self.model.count = _countView.count;
}

@end
