//
//  FavoriteListTableViewController.m
//  MoreWine
//
//  Created by Thunder on 14-5-13.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import "FavoriteListTableViewController.h"
#import "InfoCell.h"
#import "EzInfoCell.h"
#import "ShopDetailViewController.h"

@interface FavoriteListTableViewController ()

@end

@implementation FavoriteListTableViewController
@synthesize viewType;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([viewType isEqual:@"shop"])
        self.tableView.rowHeight = 110.0f;
    else
        self.tableView.rowHeight = 70.0f;

    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if ([viewType isEqualToString:@"shop"])
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        else
            cell = [[EzInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.numberOfLines = 0;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([viewType isEqualToString:@"shop"])
        [(InfoCell*)cell setCellInfo:nil];
    else
        [(EzInfoCell*)cell setCellInfo:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // test pushViewController
    ShopDetailViewController* viewController = [[ShopDetailViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
}

@end
