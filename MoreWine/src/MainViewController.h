//
//  MainViewController.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate>
{
    UISearchBar* _searchBar;
    
    UIView* _headerContainerView;
    
    UIScrollView* _scrollView;
    UITableView* _tableView;
    UIView* _scrollingContentView;

    UIRefreshControl* _refreshControl;
}
@end
