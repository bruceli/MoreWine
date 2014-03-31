//
//  ShakeViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShakeViewController.h"
#import "ADDropDownMenuView.h"
#import "ADDropDownMenuItemView.h"
#import "MaPopupMenuController.h"

@interface ShakeViewController () <ADDropDownMenuDelegate>

@end

@implementation ShakeViewController

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
    self.view.backgroundColor = [UIColor blueColor];
    [self setupHeaderViews];
    [self setupDropDownMenus];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupHeaderViews
{
}

-(void)setupDropDownMenus
{
    /*
    NSArray* baseLiqTitleArray = [NSArray arrayWithObjects:@"基酒",@"酒1",@"酒2",@"酒3"@"基酒",@"酒1",@"酒2",@"酒3",@"酒2",@"酒3"@"基酒",@"酒2",@"酒3"@"基酒",@"酒2",@"酒3"@"基酒",@"酒2",@"酒3"@"基酒",nil];
    NSArray* baseLiqItemArray = [self dropDownItemsWithTitleArray:baseLiqTitleArray];
    _baseLiqMenu = [self dropDownMenuWithPoint:CGPointMake(0, 64) menuArray:baseLiqItemArray];
    NSLog(@"baseLiq at %@",NSStringFromCGRect(_baseLiqMenu.frame));
    [self.view addSubview:_baseLiqMenu];
    
    NSArray* tastTitleArray = [NSArray arrayWithObjects:@"tast",@"12%",@"36%",@"50%",nil];
    NSArray* tastLiqItemArray = [self dropDownItemsWithTitleArray:tastTitleArray];
    _tastMenu = [self dropDownMenuWithPoint:CGPointMake(160, 64) menuArray:tastLiqItemArray];
     NSLog(@"tast at %@",NSStringFromCGRect(_tastMenu.frame));
    [self.view addSubview:_tastMenu];
    
 */
    
    
    
    MaPopupMenuController *controller = [[MaPopupMenuController alloc] initWithStyle:UITableViewStylePlain];

}

-(NSArray*)dropDownItemsWithTitleArray:(NSArray*)array
{
    NSMutableArray* itemsArray = [[NSMutableArray alloc] init];
    
    for (NSString* theTitle in array) {
        ADDropDownMenuItemView* menuItem = [self dropDownItemWithTitle:theTitle];
        [itemsArray addObject:menuItem];
    }
    
    return itemsArray;
}

-(ADDropDownMenuView*)dropDownMenuWithPoint:(CGPoint)point menuArray:(NSArray*)menuItemArray
{
    ADDropDownMenuView *dropDownMenuView = [[ADDropDownMenuView alloc] initAtOrigin:point withItemsViews:menuItemArray];
    dropDownMenuView.delegate = self;
    dropDownMenuView.separatorColor = [UIColor blackColor];
    
   /* NSArray* subViewArray =  [dropDownMenuView subviews];
    for (UIView* theSubView in subViewArray) {
        if (theSubView.tag == 1919101910)
        { // #define DIM_VIEW_TAG 1919101910  == the dim view was defined in ADDropDownMenuView.m
            NSLog(@"%@", @"dimView found");
            theSubView.backgroundColor = [UIColor clearColor];
            }
    }
   */
    return dropDownMenuView;
}

- (ADDropDownMenuItemView *)dropDownItemWithTitle:(NSString *)title{
    ADDropDownMenuItemView *item = [[ADDropDownMenuItemView alloc] initWithSize: CGSizeMake(160, 40)];
    item.titleLabel.text = title;
    [item setTitleColor:[UIColor colorWithRed:161./255. green:163./255. blue:163./255. alpha:1.] forState:ADDropDownMenuItemViewStateNormal];
    //    [item setBackgroundImage:[UIImage imageNamed:@"ADDropDownMenuItemNormalImage"] forState:ADDropDownMenuItemViewStateNormal];
    //    [item setBackgroundImage:[UIImage imageNamed:@"ADDropDownMenuItemSelectedImage"] forState:ADDropDownMenuItemViewStateSelected];
    //    [item setBackgroundImage:[UIImage imageNamed:@"ADDropDownMenuItemHighlightedImage"] forState:ADDropDownMenuItemViewStateHighlighted];
    return item;
}

#pragma mark - ADDropDownMenuDelegate

- (void)ADDropDownMenu:(ADDropDownMenuView *)view didSelectItem:(ADDropDownMenuItemView *)item{
    NSLog(@"%@ selected", item.titleLabel.text);
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
