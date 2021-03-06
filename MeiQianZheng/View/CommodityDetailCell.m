//
//  CommodityDetailCell.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityDetailCell.h"

@interface CommodityDetailCell()

@property (nonatomic,strong) UILabel * infoLabel;
@property (nonatomic,strong) UILabel * contentLabel;

@end

@implementation CommodityDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addElements];
    }
    return self;
}

- (void)addElements
{
    CGFloat width = KScreenWidth / 2;
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kDetailCellHeight)];
    self.infoLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.infoLabel];
    
    CGFloat infoLabelX = CGRectGetMaxX(_infoLabel.frame);
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoLabelX, 0, width, kDetailCellHeight)];
    self.contentLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.contentLabel];
    
    UILabel * sepline = [[UILabel alloc] initWithFrame:CGRectMake(0, kDetailCellHeight - 0.8, KScreenWidth, 0.8)];
    [sepline setBackgroundColor:kDefaultColor];
    [self.contentView addSubview:sepline];
}

-(void)setInfo:(NSString *)info
{
    _info = info;
    [_infoLabel setText:info];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    [_contentLabel setText:content];
}

@end
