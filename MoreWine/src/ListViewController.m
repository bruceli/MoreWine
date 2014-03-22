//
//  ListViewController.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ListViewController.h"
#import "InfoCell.h"
#import "MaUtility.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

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
	// Do any additional setup after loading the view.
    
    
	//blurImageView
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];
	_bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bkgBlurImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bkgBlurImageView.alpha = 1;
    [_bkgBlurImageView setImageToBlur:image blurRadius:10 completionBlock:nil];
    [self.view addSubview:_bkgBlurImageView];    

    // UISearchBar Init
    // _searchDisplayController for reference http://cocoabob.net/?p=67
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
	_searchBar.translucent = YES;
	_searchBar.barStyle = UIBarStyleBlack;
	_searchBar.delegate = self;
	_searchBar.tintColor = [UIColor whiteColor];

    [self.view addSubview:_searchBar];
    /* when tap searchBar,
     1, hide statusBar/NavBar,
     2, show Cancel botton,
     3, show catgory lables,
     */

//    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-64); // navBar height
    //frame	CGRect	origin=(x=0, y=0) size=(width=320, height=454) //run time
    CGRect frame = CGRectMake(self.view.frame.origin.x, 44, self.view.frame.size.width, self.view.frame.size.height-64); // navBar height
  
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 110.0f;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UISearchBar delegete.
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
