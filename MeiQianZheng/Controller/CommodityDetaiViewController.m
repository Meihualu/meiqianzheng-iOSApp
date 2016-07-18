//
//  CommodityDetaiViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityDetaiViewController.h"
#import "DetailTableViewDelegate.h"
#import "DetailTableViewDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CommodityDetailViewModel.h"
#import "ShoppingCarViewController.h"

const CGFloat bottomHeight = 60.0f;

@interface CommodityDetaiViewController ()

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * addToShoppingCar;
@property (nonatomic,strong) UIButton   * purchase;
@property (nonatomic,strong) UIButton * addItemBtn;
@property (nonatomic,strong) UIButton * reduceItemBtn;
@property (nonatomic,strong) UITextField * itemCount;
@property (nonatomic,strong) DetailTableViewDelegate * detailDelegate;
@property (nonatomic,strong) DetailTableViewDataSource * detailDataSource;
@property (nonatomic,strong) CommodityDetailViewModel * viewModel;
@property (nonatomic,strong) UIButton * shoppingCarBtn;
@end

@implementation CommodityDetaiViewController

- (instancetype)initWithCommodityModel:(CommodityModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _viewModel = [[CommodityDetailViewModel alloc] init];
    _viewModel.model = _model;
    _detailDelegate = [[DetailTableViewDelegate alloc] init];
    _detailDataSource = [[DetailTableViewDataSource alloc] init];
    _detailDataSource.model = _model;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kMargin, kMargin, kViewWidth - kMargin * 2, kViewHeight - kMargin * 2 - bottomHeight - kApplicationFrameHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = _detailDelegate;
    _tableView.dataSource = _detailDataSource;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
    
    [self addShoppingCarBtn];
    [self addTableFooterView];
    [self addBottomView];
    
    [self addSignals];
}

- (void)addSignals
{
    [self.itemCount.rac_textSignal subscribeNext:^(NSString * text) {
        //调用viewModel的相关方法
        [self.viewModel dealTextFieldTextChangeWithText:text];
    }];
    
    [[self.addItemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //调用viewModel的相关方法
        [self.viewModel addNumberOfItem];
    }];
    
    [[self.reduceItemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //调用viewModel的相关方法
        [self.viewModel reduceNumberOfItem];
    }];
    
    //监听ViewModel数值 赋值UILabel
    RAC(self.itemCount,text) = [RACObserve(self.viewModel.model, count) map:^id(id count) {
        return [NSString stringWithFormat:@"%@",count];
    }];
    
//    RAC(self.labelRoundNumber, text) = RACObserve(self.homePageVM, waitNum);
    
    [[self.addToShoppingCar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //调用viewModel的相关方法
        [self.viewModel addShoppingCar];
    }];
    
    [[self.purchase rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel addShoppingCar];
        //调用viewModel的相关方法
        ShoppingCarViewController * shoppingCar = [[ShoppingCarViewController alloc] init];
        [self.navigationController pushViewController:shoppingCar animated:YES];
    }];
    
    [[_shoppingCarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ShoppingCarViewController * shoppcingCar = [[ShoppingCarViewController alloc] init];
        [self.navigationController pushViewController:shoppcingCar animated:YES];
    }];
    
}

- (void)addShoppingCarBtn
{
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [button setImage:[UIImage imageNamed:@"shoppingcar"] forState:UIControlStateNormal];
    _shoppingCarBtn = button;
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addTableFooterView
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, kDetailCellHeight * 2)];
    CGFloat itemWidth = 40.0f;
    CGFloat itemHeight = 30.0f;
    CGFloat itemY = (kDetailCellHeight * 2 - itemHeight) / 2;
    CGFloat itemX = (_tableView.frame.size.width - itemWidth) / 2;
    _itemCount = [[UITextField alloc] initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemHeight)];
    _itemCount.font = [UIFont systemFontOfSize:12.0f];
    _itemCount.textAlignment = NSTextAlignmentCenter;
    _itemCount.borderStyle = UITextBorderStyleRoundedRect;
    _itemCount.text = @"0";
    
    _addItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemX - itemWidth - kMargin / 2, itemY, itemWidth, itemHeight)];
    [_addItemBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addItemBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_addItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addItemBtn.layer setBorderWidth:0.8f];
    [_addItemBtn.layer setCornerRadius:5.0f];
    [_addItemBtn.layer setBorderColor:kDefaultColor.CGColor];
    
    _reduceItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemX + itemWidth + kMargin / 2, itemY, itemWidth, itemHeight)];
    [_reduceItemBtn setTitle:@"-" forState:UIControlStateNormal];
    [_reduceItemBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_reduceItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_reduceItemBtn.layer setBorderWidth:0.8f];
    [_reduceItemBtn.layer setCornerRadius:5.0f];
    [_reduceItemBtn.layer setBorderColor:kDefaultColor.CGColor];
    
    [footerView addSubview:_itemCount];
    [footerView addSubview:_addItemBtn];
    [footerView addSubview:_reduceItemBtn];
    self.tableView.tableFooterView = footerView;
    
    [footerView setBackgroundColor:[UIColor whiteColor]];
}

- (void) addBottomView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame) + kMargin, kViewWidth, bottomHeight)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    _addToShoppingCar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kViewWidth / 2, bottomHeight)];
    [_addToShoppingCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    _purchase = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_addToShoppingCar.frame), 0, kViewWidth / 2, bottomHeight)];
    [_purchase setTitle:@"立即购买" forState:UIControlStateNormal];
    [view addSubview:_addToShoppingCar];
    [view addSubview:_purchase];
}

@end
