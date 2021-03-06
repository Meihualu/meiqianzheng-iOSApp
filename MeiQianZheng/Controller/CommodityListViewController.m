//
//  CommodityListViewController.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityListViewController.h"
#import "ShoppingCarViewController.h"
#import "CommodityRefreshHeader.h"
#import "CommodityRefreshFooter.h"
#import "CommodityListViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ListTableViewDataSource.h"
#import "ListTableViewDelegate.h"

@interface CommodityListViewController ()
{
    CommodityRefreshHeader          * _refreshHeader;
    CommodityRefreshFooter          * _refreshFooter;
    
    NSMutableArray           * _totalSource;
    NSMutableArray           * _categories;
    
    CommodityListViewModel           * _tableViewModel;
    
    UITableView              * _tableView;
    UIButton                  * _shoppingCarBtn;
    UIButton                  * _commodityAll;
    UIButton                  * _salesAll;
    UIButton                  * _sales95;
    UIButton                  * _salesTwoPlusOne;
    
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
    
    [self addTableView];
    [self addRefresh];
    [self addShoppingCarBtn];
    [self addHeaderView];
    [self addSignals];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _tableViewDataSource = [[ListTableViewDataSource alloc] init];
    _tableViewDelegate = [[ListTableViewDelegate alloc] init];
    _tableViewDelegate.navController = self.navigationController;
    _tableView.dataSource = _tableViewDataSource;
    _tableView.delegate = _tableViewDelegate;
    
    _tableViewModel = [[CommodityListViewModel alloc] init];
    _totalSource = 0;

}

/**
 *  刷新相关设置
 */
- (void)addRefresh
{
    _refreshHeader = [[CommodityRefreshHeader alloc] init];
    _refreshHeader.scrollView = _tableView;
    [_refreshHeader header];
    __weak typeof(self) weakSelf = self;
    _refreshHeader.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    };
    
    //    是否在进入该界面的时候就开始进入刷新状态
    [_refreshHeader beginRefreshing];
    
    _refreshFooter=[[CommodityRefreshFooter alloc] init];
    _refreshFooter.scrollView=_tableView;
    [_refreshFooter footer];
    
    _refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
}

/**
 *  添加导航栏购物车按钮
 */
- (void)addShoppingCarBtn
{
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(8, 24, 8, -8)];
    [button setImage:[UIImage imageNamed:@"shoppingcar"] forState:UIControlStateNormal];
    _shoppingCarBtn = button;
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
}

/**
 *  添加头部View
 */
- (void)addHeaderView
{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kDetailCellHeight)];
    [header setBackgroundColor:[UIColor whiteColor]];
    _tableView.tableHeaderView = header;
    CGFloat width = kViewWidth / 4;
    _commodityAll = [self buttonWithFrame:CGRectMake(0, 0, width, kDetailCellHeight) title:kAllCommoditiesInfoStr];
    [_commodityAll setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [header addSubview:_commodityAll];
    
    _salesAll = [self buttonWithFrame:CGRectMake(width, 0, width, kDetailCellHeight) title:kAllSalesInfoStr];
    [header addSubview:_salesAll];
    
    _salesTwoPlusOne = [self buttonWithFrame:CGRectMake(width * 2, 0, width, kDetailCellHeight) title:kDiscountBuyTwoGetOneFreeInfoStr];
    [header addSubview:_salesTwoPlusOne];
    
    _sales95 = [self buttonWithFrame:CGRectMake(width * 3, 0, width, kDetailCellHeight) title:kPercentDiscountInfoStr];
    [header addSubview:_sales95];

}

/**
 *  添加信号关联
 */
- (void)addSignals
{
    [[_shoppingCarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ShoppingCarViewController * shoppcingCar = [[ShoppingCarViewController alloc] init];
        [self.navigationController pushViewController:shoppcingCar animated:YES];
    }];
    
    [[_salesTwoPlusOne rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [_tableViewModel filterCommoditiesWithPromotionType:kDiscountTypeBuyTwoGetOneFree callback:^(NSArray *categories, NSArray *dataSource) {
            [self setButtonTitleColorRedColorWithButton:_salesTwoPlusOne];
            [self refreshWithCategories:categories dataSource:dataSource];
        }];
    }];
    
    [[_sales95 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [_tableViewModel filterCommoditiesWithPromotionType:kDiscountPercentDiscount callback:^(NSArray *categories, NSArray *dataSource) {
            [self setButtonTitleColorRedColorWithButton:_sales95];
            [self refreshWithCategories:categories dataSource:dataSource];
        }];
    }];
    
    [[_salesAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [_tableViewModel filterCommoditiesWithPromotionType:kDiscountAllTypes callback:^(NSArray *categories, NSArray *dataSource) {
            [self setButtonTitleColorRedColorWithButton:_salesAll];
            [self refreshWithCategories:categories dataSource:dataSource];
        }];
    }];
    
    [[_commodityAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [_tableViewModel filterCommoditiesWithPromotionType:@"commodityAll" callback:^(NSArray *categories, NSArray *dataSource) {
            [self setButtonTitleColorRedColorWithButton:_commodityAll];
            [self refreshWithCategories:categories dataSource:dataSource];
        }];
    }];
    
}

/**
 *  下拉刷新处理函数
 */
- (void)headerRefreshAction
{
    [_tableViewModel headerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        [self refreshWithCategories:categories dataSource:dataSource];
    }];
}


/**
 *  上拉刷新处理函数
 */
- (void)footerRefreshAction
{
    [_tableViewModel footerRefreshRequestWithCallback:^(NSArray *categories,NSArray * dataSource){
        if (categories.count == 0) {
            [Alert showAlert:@"暂无更新"];
        } else {
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

#pragma mark --private方法
- (void) refreshWithCategories:(NSArray *)categories dataSource:(NSArray *)dataSource
{
    if (dataSource.count > 0) {
        _totalSource=[NSMutableArray arrayWithArray:dataSource];
        _categories = [NSMutableArray arrayWithArray:categories];
        
        _tableViewDataSource.dataSource = _totalSource;
        _tableViewDataSource.categories = _categories;
        
        _tableViewDelegate.array = _totalSource;
        [_tableView reloadData];
    } else {
        [Alert showAlert:@"暂无商品"];
    
    }
    [_refreshHeader endRefreshing];
    
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title
{
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

- (void)setButtonTitleColorRedColorWithButton:(UIButton *)button
{
    [_salesTwoPlusOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sales95 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_salesAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commodityAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
