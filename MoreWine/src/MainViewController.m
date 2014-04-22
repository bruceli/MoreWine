//
//  MainViewController.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MainViewController.h"

#import "AppDelegate.h"
#import "MaUtility.h"
#import "MaDataSettingManager.h"
#import "ShopDetailViewController.h"

#import "SGFocusImageItem.h"
#import "EzInfoCell.h"

#define TableView_HeaderView_Height 154

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //	[self preLoadTableViewCells];
    self.view.backgroundColor = [UIColor clearColor];
    // ContainerView
    _headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 153)];
    
    // MaScrolling Content
	[self setupHilightImageView];
    [_headerContainerView addSubview:_hilightImageView];
    
	// height in 43 points
    // UISearchBar Init
    // _searchDisplayController for reference http://cocoabob.net/?p=67
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
    _tableView.rowHeight = 70.0f;
    _tableView.separatorColor = [UIColor clearColor];
	_tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headerContainerView;
    
    //    _tableView refresh controler
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
//    id dele = self.navigationController.delegate;
    [self.view addSubview:_tableView];
}

-(UIButton*)setupButtonBy:(CGRect)frame
{
    UIButton *theButton = [[UIButton alloc] initWithFrame:frame];
	theButton.layer.cornerRadius=4.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 1.0f;
    theButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return theButton;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setupHilightImageView
{
	//    _hilightImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, TableView_HeaderView_Height)];
    
//	AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    /*
     if ([app.dataSettingMgr.hilightDataArray count]<1) {
     [self loadSlides];
     return;
     }
     */
	NSMutableArray* _scrollingArray = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
	
	NSMutableArray* scrItemArray = [[NSMutableArray alloc] init];
	if( [_scrollingArray count]>0){
		for (int i = 0; i < [_scrollingArray count] ; i++) {
            //  NSDictionary* dict = [_scrollingArray objectAtIndex:i];
			//            NSLog(@"Item %d,%@", i,dict);
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"title" image:@"" targetURL:@""  tag:i];
			NSLog(@"%@",@"create SGFocusImageItem");
            //	SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:[[dict objectForKey:@"title"] URLDecodedString] image:[[dict objectForKey:@"smallimg"] URLDecodedString] targetURL:[[dict objectForKey:@"link"] URLDecodedString]  tag:i];
			[scrItemArray addObject:item];
		}
	}
	SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TableView_HeaderView_Height) delegate:self focusImageItemArray:scrItemArray];
    _hilightImageView = imageFrame;
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
	NSInteger count = 0;
	if (tableView == _tableView) {
		count = 12;
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
		count = 0;
        NSLog(@"%@",@"searchDisplayController CELL");
	}
	
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EzCell";

    EzInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[EzInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.numberOfLines = 0;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell setCellInfo:nil];
    }

	if (tableView == _tableView) {
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"%@",@"searchDisplayController CELL");
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
//	[self scrollTableViewIfNeeded];
//    [self.searchDisplayController setActive:YES animated:YES];

    //	- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated NS_AVAILabel_IOS(3_0);
//	[_searchBar setShowsCancelButton:YES animated:YES];
	NSLog(@"searchBarTextDidBeginEditing");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"The search text is: %@", searchText);
}

- (void)searchBaqrTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing");
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;	// called when cancel button pressed
{
    NSLog(@"searchBarCancelButtonClicked");
	[_searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

-(void)scrollTableViewIfNeeded
{
	if (_tableView.contentOffset.y < TableView_HeaderView_Height) {
//		NSLog(@"TableCurrentLocation %f, --- Scrolling",_tableView.contentOffset.y);
		[_tableView setContentOffset:CGPointMake(0, TableView_HeaderView_Height)animated:YES];
		//- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;  // animate at constant velocity to new offset
	}
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
}


#pragma mark - SGFocusImageFramedelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%@ ", @"FocusImage tap");
    //    NSString* urlString = [item.targetURL URLDecodedString ];
    
    //    [self.navigationController pushViewController: bbsViewController animated:YES];
}





@end
