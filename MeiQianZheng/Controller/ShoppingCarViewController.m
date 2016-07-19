//
//  ShoppingCarViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "SettlementViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "ShoppingCarViewModel.h"
#import "ShoppingCarTableViewDelegate.h"
#import "ShoppingCarTableViewDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ShoppingCarViewController ()
{
    YiRefreshHeader          * _refreshHeader;
    YiRefreshFooter          * _refreshFooter;
    
    NSMutableArray           * _totalSource;
    NSMutableArray           * _categories;
    
    ShoppingCarViewModel         * _shoppingCarViewModel;
    
    UITableView              * _tableView;
    UIButton                  * _settlement;
    ShoppingCarTableViewDataSource       * _tableViewDataSource;
    ShoppingCarTableViewDelegate         * _tableViewDelegate;
}
@end

@implementation ShoppingCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    self.title=@"购物车";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableViewDataSource = [[ShoppingCarTableViewDataSource alloc] init];
    _tableViewDelegate = [[ShoppingCarTableViewDelegate alloc] init];
    _tableViewDelegate.navController = self.navigationController;
    _tableView.dataSource = _tableViewDataSource;
    _tableView.delegate = _tableViewDelegate;
    _tableViewDataSource.refreshHeader = _refreshHeader;
    
    _shoppingCarViewModel = [[ShoppingCarViewModel alloc] init];
    _totalSource = 0;
    
    _refreshHeader = [[YiRefreshHeader alloc] init];
    _refreshHeader.scrollView = _tableView;
    [_refreshHeader header];
    __weak typeof(self) weakSelf = self;
    _refreshHeader.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    };
    
    //是否在进入该界面的时候就开始进入刷新状态
    [_refreshHeader beginRefreshing];
    
    _refreshFooter=[[YiRefreshFooter alloc] init];
    _refreshFooter.scrollView=_tableView;
    [_refreshFooter footer];
    
    _refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
    [self addSettlementCarBtn];
    [self addSignals];
}

- (void)addSettlementCarBtn
{
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setTitle:@"结算" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    _settlement = button;
    
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addSignals
{
    [[_settlement rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if (_tableViewDataSource.dataSource.count > 0) {
            SettlementViewController * settlement = [[SettlementViewController alloc] initWithCommodities:_tableViewDataSource.dataSource];
            [self.navigationController pushViewController:settlement animated:YES];
        } else {
            [Alert showAlert:@"亲，请添加要购买商品~"];
        }
        
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerRefreshAction) name:kNotificationDeleteFromShoppingCar object:nil];
}

- (void)headerRefreshAction
{
    [_shoppingCarViewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        _totalSource=[NSMutableArray arrayWithArray:dataSource];
        _categories = [NSMutableArray arrayWithArray:categories];
        
        _tableViewDataSource.dataSource = _totalSource;
        _tableViewDataSource.categories = _categories;
        
        _tableViewDelegate.array = _totalSource;
        if (dataSource.count > 0) {
            _settlement.enabled = YES;
        }
        [_refreshHeader endRefreshing];
        [_tableView reloadData];
    }];
}

- (void)footerRefreshAction
{
    [_shoppingCarViewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        if (categories.count == 0) {
            [Alert showAlert:@"暂无更新"];
        }else{
            _totalSource=[NSMutableArray arrayWithArray:dataSource];
            _categories = [NSMutableArray arrayWithArray:categories];
            
            _tableViewDataSource.dataSource = _totalSource;
            _tableViewDataSource.categories = _categories;
            _tableViewDelegate.array=_totalSource;
            [_tableView reloadData];
            
        }
        [_refreshFooter endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
