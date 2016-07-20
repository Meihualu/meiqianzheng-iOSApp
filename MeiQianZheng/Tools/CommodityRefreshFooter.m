
//
//  YiRefreshFooter.m
//  MeiQianZheng
//
//  Created by msn on 16/7/16.
//  Copyright © 2016年 ZYL. All rights reserved.
//

#import "CommodityRefreshFooter.h"
@interface CommodityRefreshFooter (){
    float                   _contentHeight;
    float                   _scrollFrameHeight;
    float                   _footerHeight;
    float                   _scrollWidth;
    BOOL                    _isAdd;
    BOOL                    _isRefresh;
    
    UIView                  * _footerView;
    UIActivityIndicatorView    * _activityView;
}
@end

@implementation CommodityRefreshFooter

-(void)footer{
    _scrollWidth=_scrollView.frame.size.width;
    _footerHeight=35;
    _scrollFrameHeight=_scrollView.frame.size.height;
    _isAdd=NO;
    _isRefresh=NO;
    
    _footerView=[[UIView alloc] init];
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
     _contentHeight=_scrollView.contentSize.height;
    if (!_isAdd) {
        _isAdd=YES;
        _footerView.frame=CGRectMake(0, _contentHeight, _scrollWidth, _footerHeight);
        [_scrollView addSubview:_footerView];
        _activityView.frame=CGRectMake((_scrollWidth-_footerHeight)/2, 0, _footerHeight, _footerHeight);
        [_footerView addSubview:_activityView];
    }
    _footerView.frame=CGRectMake(0, _contentHeight, _scrollWidth, _footerHeight);
    _activityView.frame=CGRectMake((_scrollWidth-_footerHeight)/2, 0, _footerHeight, _footerHeight);
    int currentPostion = _scrollView.contentOffset.y;
    //进入刷新状态
    if ((currentPostion>(_contentHeight-_scrollFrameHeight))&&(_contentHeight>_scrollFrameHeight)) {
        [self beginRefreshing];
    }
}

/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
-(void)beginRefreshing{
    if (!_isRefresh) {
        _isRefresh=YES;
        [_activityView startAnimating];
        //设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, _footerHeight, 0);
        }];
        //block回调
        _beginRefreshingBlock();
    }
}

-(void)endRefreshing{
     _isRefresh=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [_activityView stopAnimating];
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, _footerHeight, 0);
            _footerView.frame=CGRectMake(0, _contentHeight, KScreenWidth, _footerHeight);
        }];
    });
}

-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
