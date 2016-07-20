//
//  YiRefreshHeader.m
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiRefreshHeader.h"
@interface YiRefreshHeader ()
{
    float                   _lastPosition;
    float                   _contentHeight;
    float                   _headerHeight;
    BOOL                    _isRefresh;
    
    UILabel               * _headerLabel;
    UIView                * _headerView;
    UIImageView            * _headerIV;
    UIActivityIndicatorView  * _activityView;
}
@end

@implementation YiRefreshHeader
-(void)header{
    _isRefresh=NO;
    _lastPosition=0;
    _headerHeight=35;
    float scrollWidth=_scrollView.frame.size.width;
    float imageWidth=13;
    float imageHeight=_headerHeight;
    float labelWidth=130;
    float labelHeight=_headerHeight;

    _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, -_headerHeight-10, _scrollView.frame.size.width, _headerHeight)];
      [_scrollView addSubview:_headerView];
    
    _headerLabel=[[UILabel alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2, 0, labelWidth, labelHeight)];
    [_headerView addSubview:_headerLabel];
    _headerLabel.textAlignment=NSTextAlignmentCenter;
    _headerLabel.text=@"下拉可刷新";
    _headerLabel.font=[UIFont systemFontOfSize:14];
    
    
    _headerIV=[[UIImageView alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight)];
    [_headerView addSubview:_headerIV];
    _headerIV.image=[UIImage imageNamed:@"down"];

    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame=CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight);
    [_headerView addSubview:_activityView];
    
    _activityView.hidden=YES;
    _headerIV.hidden=NO;
    
    //为_scrollView设置KVO的观察者对象，keyPath为contentOffset属性
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

/**
 *  当属性的值发生变化时，自动调用此方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    //获取_scrollView的contentSize
    _contentHeight=_scrollView.contentSize.height;

    //判断是否在拖动_scrollView
    if (_scrollView.dragging) {
        int currentPostion = _scrollView.contentOffset.y;
        //判断是否正在刷新  否则不做任何操作
        if (!_isRefresh) {
            [UIView animateWithDuration:0.3 animations:^{
                //当currentPostion 小于某个值时 变换状态
                if (currentPostion<-_headerHeight*1.5) {
                    _headerLabel.text=@"松开以刷新";
                    _headerIV.transform = CGAffineTransformMakeRotation(M_PI);
                } else {
                    int currentPostion = _scrollView.contentOffset.y;
                    //判断滑动方向 以让“松开以刷新”变回“下拉可刷新”状态
                    if (currentPostion - _lastPosition > 5) {
                        _lastPosition = currentPostion;
                        _headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
                        _headerLabel.text=@"下拉可刷新";
                    } else if (_lastPosition - currentPostion > 5) {
                        _lastPosition = currentPostion;
                    }
                }
            }];
        }
    } else {
        //进入刷新状态
        if ([_headerLabel.text isEqualToString:@"松开以刷新"]) {
            [self beginRefreshing];
        }
    }
}

/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
-(void)beginRefreshing{
    if (!_isRefresh) {
        _isRefresh=YES;
        _headerLabel.text=@"正在载入…";
        _headerIV.hidden=YES;
        _activityView.hidden=NO;
        [_activityView startAnimating];
        //设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentInset=UIEdgeInsetsMake(_headerHeight*1.5, 0, 0, 0);
        }];
        _beginRefreshingBlock();
    }
}

/**
 * 关闭刷新操作
 */
-(void)endRefreshing{
    _isRefresh=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            _headerIV.hidden=NO;
            _headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
            [_activityView stopAnimating];
            _activityView.hidden=YES;
        }];
    });
}

-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
