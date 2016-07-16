//
//  CommodityListViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityListViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "CommodityListViewModel.h"

#import "ListTableViewDataSource.h"
#import "ListTableViewDelegate.h"

@interface CommodityListViewController ()
{
    YiRefreshHeader          * _refreshHeader;
    YiRefreshFooter          * _refreshFooter;
    
    NSMutableArray           * _totalSource;
    
    CommodityListViewModel           * _tableViewModel;
    
    UITableView              * _tableView;
    
    ListTableViewDataSource       * _tableViewDataSource;
    ListTableViewDelegate         * _tableViewDelegate;
}
@end

@implementation CommodityListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    self.title=@"商品列表";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableViewDataSource = [[ListTableViewDataSource alloc] init];
    _tableViewDelegate = [[ListTableViewDelegate alloc] init];
    _tableViewDelegate.navController = self.navigationController;
    _tableView.dataSource = _tableViewDataSource;
    _tableView.delegate = _tableViewDelegate;
    
    _tableViewModel = [[CommodityListViewModel alloc] init];
    _totalSource = 0;
    
    //    YiRefreshHeader  头部刷新按钮的使用
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
    
    //    YiRefreshFooter  底部刷新按钮的使用
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
    [_tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        _totalSource=(NSMutableArray *)array;
        _tableViewDataSource.array = _totalSource;
        _tableViewDelegate.array = _totalSource;
        [_refreshHeader endRefreshing];
        [_tableView reloadData];
    }];
}

- (void)footerRefreshAction
{
    [_tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [_totalSource addObjectsFromArray:array] ;
        _tableViewDataSource.array=_totalSource;
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
