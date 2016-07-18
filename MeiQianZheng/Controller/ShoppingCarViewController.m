//
//  ShoppingCarViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/17.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "ShoppingCarViewModel.h"
#import "ShoppingCarTableViewDelegate.h"
#import "ShoppingCarTableViewDataSource.h"

@interface ShoppingCarViewController ()
{
    YiRefreshHeader          * _refreshHeader;
    YiRefreshFooter          * _refreshFooter;
    
    NSMutableArray           * _totalSource;
    NSMutableArray           * _categories;
    
    ShoppingCarViewModel         * _shoppingCarViewModel;
    
    UITableView              * _tableView;
    
    ShoppingCarTableViewDataSource       * _tableViewDataSource;
    ShoppingCarTableViewDelegate         * _tableViewDelegate;
}
@end

@implementation ShoppingCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    self.title=@"商品列表";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableViewDataSource = [[ShoppingCarTableViewDataSource alloc] init];
    _tableViewDelegate = [[ShoppingCarTableViewDelegate alloc] init];
    _tableViewDelegate.navController = self.navigationController;
    _tableView.dataSource = _tableViewDataSource;
    _tableView.delegate = _tableViewDelegate;
    
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
    
    //    是否在进入该界面的时候就开始进入刷新状态
    [_refreshHeader beginRefreshing];
    
    _refreshFooter=[[YiRefreshFooter alloc] init];
    _refreshFooter.scrollView=_tableView;
    [_refreshFooter footer];
    
    _refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
    
}

- (void)headerRefreshAction
{
    [_shoppingCarViewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        _totalSource=[NSMutableArray arrayWithArray:dataSource];
        _categories = [NSMutableArray arrayWithArray:categories];
        
        _tableViewDataSource.dataSource = _totalSource;
        _tableViewDataSource.categories = _categories;
        
        _tableViewDelegate.array = _totalSource;
        [_refreshHeader endRefreshing];
        [_tableView reloadData];
    }];
}

- (void)footerRefreshAction
{
    [_shoppingCarViewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        _totalSource=[NSMutableArray arrayWithArray:dataSource];
        _categories = [NSMutableArray arrayWithArray:categories];
        
        _tableViewDataSource.dataSource = _totalSource;
        _tableViewDataSource.categories = _categories;
        _tableViewDelegate.array=_totalSource;
        [_refreshFooter endRefreshing];
        [_tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
