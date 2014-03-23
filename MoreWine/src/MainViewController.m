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
#import "MaUtility.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "SGFocusImageItem.h"
//#import "SGFocusImageFrame.h"
#import "AppDelegate.h"
#import "MaDataSettingManager.h"
#import "ShopDetailViewController.h"

#define TableView_HeaderView_Height 154

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
    //	[self preLoadTableViewCells];
    
    // ContainerView
    _headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 153)];
    
    // MaScrolling Content
	[self setupHilightImageView];
    [_headerContainerView addSubview:_hilightImageView];
    
	//blurImageView
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];
    CGRect blurFrame =self.view.frame;
    NSLog(@"mainView blur frame is %@", NSStringFromCGRect(blurFrame));
    
	_bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bkgBlurImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bkgBlurImageView.alpha = 1;
    [_bkgBlurImageView setImageToBlur:image blurRadius:1 completionBlock:nil];
    [self.view addSubview:_bkgBlurImageView];
	
	// height in 43 points
    // UISearchBar Init
    // _searchDisplayController for reference http://cocoabob.net/?p=67
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 44)];
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
	_searchBar.searchBarStyle = UISearchBarStyleMinimal;
	_searchBar.translucent = YES;
	_searchBar.barStyle = UIBarStyleBlack;
	_searchBar.delegate = self;
	_searchBar.tintColor = [UIColor whiteColor];
    [self.view addSubview:_searchBar];
    
    // UITableView init
	NSLog(@"self.view frame is %@", NSStringFromCGRect(self.view.frame) );
    CGRect frame = CGRectMake(0, 64+44, self.view.frame.size.width, self.view.frame.size.height - 113-44); // navBar&tabBar height
	NSLog(@"_tableView frame is %@", NSStringFromCGRect(frame) );
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



-(void)setupHilightImageView
{
	//    _hilightImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, TableView_HeaderView_Height)];
    
	AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    // Return the number of rows in the section.
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EzCell";
	// return pre-loaded cells
    /*	if (indexPath.row > 4 && indexPath.row < 7) {
     EzInfoCell *cell = [_preLoadTableCellArray objectAtIndex:indexPath.row];
     if (cell != Nil) {
     NSLog(@"Set pre-load cells %d", indexPath.row);
     return cell;
     }
     }
     */
    EzInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //	NSLog(@"Cell for index %d", indexPath.row);
    if (cell == nil) {
        
        cell = [[EzInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
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
//    UIViewController* viewController = [[UIViewController alloc] init];
//    [self.navigationController pushViewController: viewController animated:YES];
    UIViewController* shopDetailViewController = [[ShopDetailViewController alloc] init];
    [self.navigationController pushViewController:shopDetailViewController animated:YES];
}

#pragma mark - UISearchBar delegete.
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[self scrollTableViewIfNeeded];
    //	- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
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

#pragma mark  Pre-load tableView cells
-(void)preLoadTableViewCells
{
	// pre-load 3-7 Cell
	// Reload load Cells if dataSource changed
	// return nil if cell does not exist
    //	NSArray* dataArray = [];
    //	[NSThread detachNewThreadSelector:@selector(preLoadCellWorkThread:) toTarget:self withObject:nil];
    //	performSelectorInBackground:(SEL)aSelector withObject:(id)arg
	NSThread* workerThread = [[NSThread alloc] initWithTarget:self selector:@selector(preLoadCellWorkThread:) object:nil];
	[workerThread start];
}

-(void)preLoadCellWorkThread:(NSArray*)dataArray
{
	_preLoadTableCellArray = [[NSMutableArray alloc] initWithCapacity:7];
	
	for (NSInteger i = 0; i<7; i++) {
		if (i<4)
		{
			NSLog(@"Pre-load cells skip ... %d",i);
			[_preLoadTableCellArray addObject: [NSNull null]];
		}
		else
		{
			NSLog(@"Pre-load cells... %d",i);
			static NSString *CellIdentifier = @"EzCell";
			EzInfoCell* cell = [[EzInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
												 reuseIdentifier:CellIdentifier];
			cell.backgroundColor = [UIColor clearColor];
			cell.detailTextLabel.numberOfLines = 0;
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			[cell setCellInfo:nil];
			[_preLoadTableCellArray addObject:cell];
		}
	}
}

/*
 -(void)revertTableViewScrollLocation
 {
 
 }
 
 -(void)saveTableViewCurrentScrollLocation
 {
 _tableViewScrollLocation = _tableView.contentOffset.y;
 }
 */

-(void)scrollTableViewIfNeeded
{
	if (_tableView.contentOffset.y < TableView_HeaderView_Height) {
		NSLog(@"TableCurrentLocation %f, --- Scrolling",_tableView.contentOffset.y);
		[_tableView setContentOffset:CGPointMake(0, TableView_HeaderView_Height)animated:YES];
		//- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;  // animate at constant velocity to new offset
	}
}

#pragma mark - SGFocusImageFrameDelegete
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%@ ", @"FocusImage tap");
    //    NSString* urlString = [item.targetURL URLDecodedString ];
    
    //    [self.navigationController pushViewController: bbsViewController animated:YES];
}



@end
