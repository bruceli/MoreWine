//
//  SearchViewController.h
//  MoreWine
//
//  Created by Thunder on 4/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaDropDownMenuController;

@interface SearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UISearchBar* _searchBar;
    UISearchDisplayController* _schDisplayController;
    MaDropDownMenuController* _dropDownController;
    UITableView* _tableView;
    UIButton* _distanceButton;
    UIButton* _labelButton;
    UIButton* _typeButton;
}
@end
