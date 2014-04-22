//
//  SearchViewController.h
//  MoreWine
//
//  Created by Thunder on 4/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "SearchViewController.h"
#import "ShopDetailViewController.h"
#import "MaDropDownMenuController.h"

#import "InfoCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    [self setupSearchStuff];
    [self setupMenuView];
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
    //	_tableView.alwaysBounceVertical = YES;
    //	_tableView.contentSize = CGSizeMake(320, 455);
	//[self.view addSubview:_tableView];

  /*
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSearchStuff
{
    
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
    
}
-(void)setupMenuView
{
    UIView* buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 40)];
    buttonView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:buttonView];

    _distanceButton = [self setupButtonByFrame:CGRectMake(0, 0, 107, 40)];
	[self setupButton:_distanceButton title:@"距离"];
	[buttonView addSubview:_distanceButton];
    
    _labelButton = [self setupButtonByFrame:CGRectMake(107, 0, 106, 40)];
	[self setupButton:_labelButton title:@"标签"];
	[buttonView addSubview:_labelButton];
    
    _typeButton = [self setupButtonByFrame:CGRectMake(213, 0, 107, 40)];
	[self setupButton:_typeButton title:@"种类"];
	[buttonView addSubview:_typeButton];
    
}

-(void)setupButton:(UIButton*)theButton title:(NSString*)theTitle
{
	//- (void)setTitle:(NSString *)title forState:(UIControlState)state;                     // default is nil. title is assumed to be single line
	[theButton setTitle:theTitle forState:UIControlStateNormal];
	theButton.titleLabel.font = [UIFont systemFontOfSize:14];
	theButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	theButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
	
	[theButton setImage:[UIImage imageNamed:@"shakeMenuArrow"] forState:UIControlStateNormal];
	[theButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
}

-(UIButton*)setupButtonByFrame:(CGRect)frame
{
    UIButton* theButton = [[UIButton alloc]initWithFrame:frame];
    theButton.backgroundColor = [UIColor clearColor];
    theButton.layer.cornerRadius=0.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 0.7f;

	[theButton addTarget:self action:@selector(popMenu:) forControlEvents:UIControlEventTouchUpInside];
    return theButton;
}


-(void)popMenu:(id)sender
{
 	_dropDownController = [[MaDropDownMenuController alloc] initWithViewController:self];
    
    [self.view addSubview:_dropDownController.view];
    [self addChildViewController:_dropDownController];
    [self didMoveToParentViewController:self];
    
	CGPoint popPoint = CGPointMake(((UIButton*)sender).frame.origin.x, ((UIButton*)sender).frame.origin.y+84);// +44 pop menu from bottom of menu;
    //	NSLog(@"popPoint %@",NSStringFromCGPoint(popPoint));
    
    [_dropDownController presentPopoverFromPoint: popPoint];

}

-(void)dismissDropDownMenuWithSelection:(id)item
{
    //    NSLog(@"%@",@"dismiss drop down menu from shake view");
    [_dropDownController.view removeFromSuperview];
    [_dropDownController removeFromParentViewController];
    _dropDownController = nil;
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




@end
