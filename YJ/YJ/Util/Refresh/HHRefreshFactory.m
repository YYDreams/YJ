//
//  HHRefreshFactory.m
//  leyingyinggame
//
//  Created by TuMi on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import "HHRefreshFactory.h"
#import <MJRefresh/MJRefresh.h>
@implementation HHRefreshFactory

+ (MJRefreshHeader *)headerRefreshWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    // 往下拉的时候文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    // 松手时候的文字
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    // 隐藏时间
     header.lastUpdatedTimeLabel.hidden = YES;
    
//    header.stateLabel.font = [UIFont systemFontOfSize:10.0];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10.0];
//    header.arrowView.image = [UIImage imageNamed:@"refreshImage"];
    
    return header;
}

+ (MJRefreshFooter *)footerRefreshWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
     [footer setTitle:@"上拉或点击加载更多" forState:MJRefreshStateIdle];
      [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
      [footer setTitle:@"已加载全部" forState:MJRefreshStateNoMoreData];

    //footer.triggerAutomaticallyRefreshPercent = -10;
//    footer.stateLabel.font = [UIFont systemFontOfSize:10.0];
    return footer;
}

@end
