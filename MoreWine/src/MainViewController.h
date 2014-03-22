//
//  MainViewController.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate,SGFocusImageFrameDelegate,UISearchBarDelegate>
{
    UISearchBar* _searchBar;

    UIView* _headerContainerView;
    UIImageView* _bkgBlurImageView;
    UIScrollView* _scrollView;
    UITableView* _tableView;
<<<<<<< HEAD

	// Pre-load tableView Cells
	NSMutableArray* _preLoadTableCellArray;
=======
//    UIView* _scrollingContentView;
>>>>>>> FETCH_HEAD
	
	SGFocusImageFrame* _hilightImageView;
    UIRefreshControl* _refreshControl;
}
@end
