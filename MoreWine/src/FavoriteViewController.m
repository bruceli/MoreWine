//
//  FavoriteViewController.m
//  MoreWine
//
//  Created by Thunder on 4/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteListTableViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

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
    _cellTitleArray = [NSArray arrayWithObjects:@"收藏的店铺",@"收藏的酒品", nil];
    // Do any additional setup after loading the view.
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
    return [_cellTitleArray count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.text = [_cellTitleArray objectAtIndex:indexPath.row];
    }
    
        
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // test pushViewController
//	ShopDetailViewController* viewController = [[ShopDetailViewController alloc] init];
//    [self.navigationController pushViewController: viewController animated:YES];
    FavoriteListTableViewController* viewController = [[FavoriteListTableViewController alloc] init];
    if (indexPath.row == 0) {
        viewController.viewType = @"shop";
    }
    else if (indexPath.row == 1) {
        viewController.viewType = @"wine";
    }
    
    
    [self.navigationController pushViewController: viewController animated:YES];

    
    /*

     */
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
