//
//  StretchableTableHeaderView.m
//  O2O
//
//  Created by sdlions on 14-12-29.
//  Copyright (c) 2014年 yingtehua. All rights reserved.
//

#import "StretchableTableHeaderView.h"

@interface StretchableTableHeaderView()
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}

@end

@implementation StretchableTableHeaderView

- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view
{
    _tableView = tableView;
    _view = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    UIView* emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    [_tableView addSubview:_view];
    
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame = f;
    
//    NSLog(@"%f", scrollView.contentOffset.y);
    
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        initialFrame.origin.y = offsetY * -1;
        initialFrame.size.height = defaultViewHeight + offsetY;
        _view.frame = initialFrame;
    }
    
//    NSLog(@"%f", _view.frame.size.height);
}

- (void)resizeView
{
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
    
    //    NSLog(@"%f", _view.frame.size.height);
}


@end
