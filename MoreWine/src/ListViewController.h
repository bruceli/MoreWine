//
//  ListViewController.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate>
{
    UITableView* _tableView;
    UISearchBar* _searchBar;
    
    UIImageView* _bkgBlurImageView;

}

@end
