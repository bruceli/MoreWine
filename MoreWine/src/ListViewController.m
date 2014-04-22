//
//  ListViewController.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ListViewController.h"

//#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "MaUtility.h"

#import "InfoCell.h"
#import "ShopDetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
	_searchBar.delegate = self;
    
	_schDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _schDisplayController.searchResultsDelegate = self;
    _schDisplayController.searchResultsDataSource = self;
    _schDisplayController.delegate = self;
    _schDisplayController.searchResultsTableView.backgroundColor = [UIColor darkGrayColor];
    _schDisplayController.searchResultsTableView.rowHeight = 70.0f;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.searchDisplayController.searchBar.translucent = NO;
    [self.view addSubview:_searchBar];
    
    // UITableView init
//	NSLog(@"self.view frame is %@", NSStringFromCGRect(self.view.frame) );
    CGRect frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 113-44); // navBar&tabBar height
//	NSLog(@"_tableView frame is %@", NSStringFromCGRect(frame) );
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 110.0f;
    _tableView.separatorColor = [UIColor clearColor];
	_tableView.backgroundColor = [UIColor clearColor];
//    _tableView.tableHeaderView = _headerContainerView;
    
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
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
//        cell.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.numberOfLines = 0;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfo:nil];
    }
  
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // test pushViewController
	ShopDetailViewController* viewController = [[ShopDetailViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
}

#pragma mark - UISearchBar delegate.
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[_searchBar setShowsCancelButton:YES animated:YES];
	NSLog(@"searchBarTextDidBeginEditing");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"The search text is: %@", searchText);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing");
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;	// called when cancel button pressed
{
    NSLog(@"searchBarCancelButtonClicked");
	[_searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSString *scope;
    
    NSInteger selectedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    if (selectedScopeButtonIndex > 0)
    {
//        scope = [[APLProduct deviceTypeNames] objectAtIndex:(selectedScopeButtonIndex - 1)];
    }
    
    [self updateFilteredContentForSearchString:searchString productType:scope];
    
    // return YES to cause the search result table view to be reloaded
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = [self.searchDisplayController.searchBar text];
    NSString *scope;
    
    if (searchOption > 0)
    {
//        scope = [[APLProduct deviceTypeNames] objectAtIndex:(searchOption - 1)];
    }
    
    [self updateFilteredContentForSearchString:searchString productType:scope];
    
    // return YES to cause the search result table view to be reloaded
    return YES;
}


#pragma mark - Content Filtering

- (void)updateFilteredContentForSearchString:(NSString *)searchString productType:(NSString *)type
{

}

@end
