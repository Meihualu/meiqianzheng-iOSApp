//
//  CommodityItem.h
//  ThoughtWorks
//
//  Created by msn on 16/5/25.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommodityModel : NSObject

/*
 已知商品信息包含：
 名称，
 数量单位，
 单价，
 类别和）
 
 以下是单个商品对象的结构：
 javascript {
    条形码(伪)  barcode: 'ITEM000000',
    名称       name: '可口可乐',
    数量单位    unit: '瓶',
    商品类别    category: '食品',
    商品子类别  subCategory:'碳酸饮料',
    单价       price: 3.00
 */

@property (nonatomic,copy) NSString * barcode;      //条形码
@property (nonatomic,copy) NSString * name;         //名称
@property (nonatomic,copy) NSString * unit;         //数量单位
@property (nonatomic,copy) NSString * category;     //类别
@property (nonatomic,copy) NSString * subCategory;  //子类别
@property (nonatomic,assign) CGFloat price;         //价格
@property (nonatomic,copy) NSArray * promotionType; //商品满足优惠信息
@property (nonatomic,assign) NSInteger count;       //购买的数量

-(instancetype)initWithBarcode:(NSString *)barcode
                          name:(NSString *)name
                          unit:(NSString *)unit
                      category:(NSString *)category
                   subCategory:(NSString *)subCategory
                         price:(CGFloat)price
                 promotionType:(NSArray *)promotionType;

- (instancetype)initWithDict:(NSDictionary *)info;

@end
