//
//  MainViewController.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView* _scrollView;
    UITableView* _tableView;
    UIView* _scrollingContentView;
}
@end
