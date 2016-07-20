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

const CGFloat bottomHeight = 50.0f;

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight - bottomHeight - kApplicationFrameHeight) style:UITableViewStyleGrouped];
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
        [self.viewModel addNumberOfItem];
    }];
    
    [[self.reduceItemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel reduceNumberOfItem];
    }];
    
    RAC(self.itemCount,text) = [RACObserve(self.viewModel.model, count) map:^id(id count) {
        return [NSString stringWithFormat:@"%@",count];
    }];
    
    [[self.addToShoppingCar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel addShoppingCar];
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:[_viewModel getPrompt] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    [[self.purchase rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel purchaseRightNow];
        if (self.viewModel.model.count == 0) {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请添加商品数量" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            ShoppingCarViewController * shoppingCar = [[ShoppingCarViewController alloc] init];
            [self.navigationController pushViewController:shoppingCar animated:YES];
        }
    }];
    
    [[_shoppingCarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ShoppingCarViewController * shoppcingCar = [[ShoppingCarViewController alloc] init];
        [self.navigationController pushViewController:shoppcingCar animated:YES];
    }];
}

- (void)addShoppingCarBtn
{
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(8, 24, 8, -8)];
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
    
    _reduceItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemX - itemWidth - kMargin / 2, itemY, itemWidth, itemHeight)];
    [_reduceItemBtn setTitle:@"-" forState:UIControlStateNormal];
    [_reduceItemBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_reduceItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_reduceItemBtn.layer setBorderWidth:0.8f];
    [_reduceItemBtn.layer setCornerRadius:5.0f];
    [_reduceItemBtn.layer setBorderColor:kDefaultColor.CGColor];
    
    _addItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemX + itemWidth + kMargin / 2, itemY, itemWidth, itemHeight)];
    [_addItemBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addItemBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [_addItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addItemBtn.layer setBorderWidth:0.8f];
    [_addItemBtn.layer setCornerRadius:5.0f];
    [_addItemBtn.layer setBorderColor:kDefaultColor.CGColor];
    
    [footerView addSubview:_itemCount];
    [footerView addSubview:_addItemBtn];
    [footerView addSubview:_reduceItemBtn];
    self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [footerView setBackgroundColor:[UIColor whiteColor]];
}

- (void) addBottomView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), kViewWidth, bottomHeight)];
    [self.view addSubview:view];
    _addToShoppingCar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kViewWidth / 2, bottomHeight)];
    [_addToShoppingCar setBackgroundImage:[UIImage imageNamed:@"addshoppingcar"] forState:UIControlStateNormal];
    
    _purchase = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_addToShoppingCar.frame), 0, kViewWidth / 2, bottomHeight)];
    [_purchase setBackgroundImage:[UIImage imageNamed:@"purchase"] forState:UIControlStateNormal];
    [view addSubview:_addToShoppingCar];
    [view addSubview:_purchase];
}

@end
