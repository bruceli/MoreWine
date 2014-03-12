//
//  MainViewController.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MainViewController.h"
#import "MaNavigationBar.h"
#import "EzInfoCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ContainerView
    _headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 197)];
    
//    [self.view addSubview:_headerContainerView];

    // height in 43 points
    // UISearchBar Init
    // _searchDisplayController for reference http://cocoabob.net/?p=67
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
    _searchBar.showsCancelButton = true;
	_searchBar.barStyle = UIBarStyleBlack;
    [_headerContainerView addSubview:_searchBar];
    // MaScrolling Content
    
    _scrollingContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 154)];
    _scrollingContentView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    [_headerContainerView addSubview:_scrollingContentView];
    
    // UITableView init
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44); // navBar height
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 65.0f;
    _tableView.separatorColor = [UIColor clearColor];
	_tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headerContainerView;

    //    _tableView refresh controler
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];

    [self.view addSubview:_tableView];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view refresh
//http://stackoverflow.com/questions/16501781/set-color-of-uiactivityindicatorview-of-a-uirefreshcontrol
// if need change indicator color...
- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl beginRefreshing];
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"喵星Refresh"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];

    [refreshControl setAttributedTitle:string];
    
    NSLog(@"%@",@"SearchControl refresh");
    [refreshControl endRefreshing];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EzCell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    EzInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[EzInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.numberOfLines = 0;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // test pushViewController
    UIViewController* viewController = [[UIViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
    
}


@end
