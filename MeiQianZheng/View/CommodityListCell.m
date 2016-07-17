//
//  CommodityListCell.m
//  MeiQianZheng
//
//  Created by msn on 16/7/14.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityListCell.h"

@interface CommodityListCell()

@property (nonatomic,strong) UIImageView * promotionImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * categoryLabel;
@property (nonatomic,strong) UILabel * priceLabel;

@end

@implementation CommodityListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * identifier = @"CommodityListCell";
    CommodityListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CommodityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self addElements];
        _cellHeight = 45.0f;
        CGFloat imageY = (_cellHeight - kMargin * 1.5) / 2;
        _promotionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, imageY, kMargin * 1.5, kMargin * 1.5)];
        _promotionImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_promotionImageView];
        
        CGFloat labelWidth = (KScreenWidth - kMargin * 3) / 3;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, labelWidth, _cellHeight)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, labelWidth, _cellHeight)];
        _categoryLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_categoryLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_categoryLabel.frame), 0, labelWidth, _cellHeight)];
        _priceLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLabel];
        
    }
    return self;
}

- (void)addElements{
    CGFloat labelWidth = (KScreenWidth - kMargin * 2) / 3;
    self.nameLabel = [self labelWithRect:CGRectMake(kMargin, 0, labelWidth, _cellHeight)];
    self.categoryLabel = [self labelWithRect:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, labelWidth, _cellHeight)];
    self.priceLabel = [self labelWithRect:CGRectMake(CGRectGetMaxX(_categoryLabel.frame), 0, labelWidth, _cellHeight)];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.categoryLabel];
    [self.contentView addSubview:self.priceLabel];
}

- (UILabel *)labelWithRect:(CGRect) frame
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    label.backgroundColor = [UIColor redColor];
    return label;
}

- (void)setModel:(CommodityModel *)model
{
    _model = model;
    [_nameLabel setText:model.name];
    [_categoryLabel setText:model.category];
    [_priceLabel setText:[NSString stringWithFormat:@"%.02f/%@",model.price,model.unit]];
    if (model.promotionType.count > 0) {
        _promotionImageView.backgroundColor = [UIColor redColor];
    } else {
        _promotionImageView.backgroundColor = [UIColor whiteColor];
    }
}

@end