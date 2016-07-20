[![Build Status](https://travis-ci.org/Meihualu/meiqianzheng-iOSApp.svg?branch=master)](https://travis-ci.org/Meihualu/meiqianzheng-iOSApp)
 
 1.工程环境说明
            操作系统：mac 10.10.5
            IDE：Xcode 7.2 
            模拟器：iPhone 5 、5s、6、6S
 
 2.项目启动说明
            请双击打开MeiQianZheng.xcworkspace打开整个项目
            Command + R 运行项目
            Command + U 运行测试代码
 
 3.项目开发简介
            项目使用CocoaPods管理i项目中使用的第三方开源库，开发中使用iOS中Kiwi BDD测试框架，通过ReactiveCocoa框架实现MVVM设计模式，同时采用Travis ci持续继承。
 
 4.项目文件说明
            源代码部分：     MeiQianZheng文件夹
            测试代码部分：   MeiQianZhengTests文件夹
            MeiQianZheng.xcodeproj：原始启动文件
            Podfile：CocoaPods配置文件
            Pods：CocoaPods生成的依赖库  
 
 3.1源代码说明
            Controller文件夹： 
            CommodityListViewController  商品列表
            CommodityDetaiViewController 商品详情页面
            ShoppingCarViewController   购物车页面
            SettlementViewController    结算清单页面
 
 
            Model 文件夹    ：  
                       CommodityModel    商品信息
                       TableViewProtocal
                       ListTableViewDataSource  商品列表页面数据源代理
                       ListTableViewDelegate    商品列表页面代理
                       DetailTableViewDataSource 商品详情页面数据源代理
                       DetailTableViewDelegate  商品详情页面代理
                       ShoppingCarTableViewDelegate  购物车页面代理
                       ShoppingCarTableViewDataSource 购物车页面数据源代理
 
 
            Tools文件夹：
                       CommodityManageTool  本地数据库操作类
 
 
            View文件夹：
                       CommodityListCell  商品列表单元格View
                       CommodityDetailCell  商品详情单元格View
                       ShoppingCarCell  购物车单元格View
                       CommodityCountView  购物车单元格 增删商品数量子View
 
 
            ViewModel文件夹：
                       CommodityListViewModel   商品列表ViewModel
                       CommodityDetailViewModel 商品详情ViewModel
                       ShoppingCarViewModel 购物车列表ViewModel
                       SettlementViewModel 结算清单ViewModel
 
 3.2测试文件说明
            ToolTest文件夹：
                       CommodityManageToolSpec  本地数据库操作类测试文件
 
 
            ViewModelTest文件夹：
                       CommodityListViewModelSpec   商品列表ViewModel测试文件
                       CommodityDetailViewModelSpec 商品详情ViewModel测试文件
                       ShoppingCarViewModelSpec 购物车列表ViewModel测试文件
                       SettlementViewModelSpec 结算清单ViewModel测试文件
 
 
            TableViewProtocalTest文件夹：
                       ListTableViewDataSourceSpec  商品列表页面数据源代理测试文件
                       ListTableViewDelegateSpec    商品列表页面代理测试文件
                       DetailTableViewDataSourceSpec 商品详情页面数据源代理测试文件
                       DetailTableViewDelegateSpec  商品详情页面代理测试文件
                       ShoppingCarTableViewDelegateSpec  购物车页面代理测试文件
                       ShoppingCarTableViewDataSourceSpec 购物车页面数据源代理测试文件  
 
 
            ControllerTest文件夹：
                       CommodityListViewControllerSpec  商品列表
                       CommodityDetaiViewControllerSpec 商品详情页面
                       ShoppingCarViewControllerSpec   购物车页面
                       SettlementViewControllerSpec    结算清单页面
 
 
            ModelTest文件夹：
                       CommodityModelSpec    商品信息测试文件
 
            ViewTest文件夹：
                       CommodityListCellSpec  商品列表单元格View测试文件
                       CommodityDetailCellSpec  商品详情单元格View测试文件
                       ShoppingCarCellSpec  购物车单元格View测试文件
 
 
 
 
 

