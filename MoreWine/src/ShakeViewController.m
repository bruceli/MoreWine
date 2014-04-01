//
//  ShakeViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShakeViewController.h"
//#import "ADDropDownMenuView.h"
//#import "ADDropDownMenuItemView.h"
#import "MaPopupMenuController.h"
#import "FPPopoverController.h"
#import "MaUtility.h"

@interface ShakeViewController ()

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
    self.view.backgroundColor = [UIColor whiteColor];
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
	/*    UIButton* _baseLiqButton;
	 UIButton* _tastButton;
	 UIButton* _tempButton;
	 UIButton* _keyWordsButton;
	 UIButton* _alcoholButton;
	 UIButton* _typeButton;
	 UIButton* _colorButton;
	 UIButton* _whatEverButton;
*/
	_baseLiqButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 160, 44)];
	_baseLiqButton.backgroundColor = [MaUtility getRandomColor];
	[_baseLiqButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_baseLiqButton];
	
	_tastButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 108, 160, 44)];
	_tastButton.backgroundColor = [MaUtility getRandomColor];
	[_tastButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_tastButton];

	_tempButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 152, 160, 44)];
	_tempButton.backgroundColor = [MaUtility getRandomColor];
	[_tempButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_tempButton];

	_keyWordsButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 196, 160, 44)];
	_keyWordsButton.backgroundColor = [MaUtility getRandomColor];
	[_keyWordsButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_keyWordsButton];

	_alcoholButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 64, 160, 44)];
	_alcoholButton.backgroundColor = [MaUtility getRandomColor];
	[_alcoholButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_alcoholButton];

	_typeButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 108, 160, 44)];
	_typeButton.backgroundColor = [MaUtility getRandomColor];
	[_typeButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_typeButton];
	
	_colorButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 152, 160, 44)];
	_colorButton.backgroundColor = [MaUtility getRandomColor];
	[_colorButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_colorButton];

	_whatEverButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 196, 160, 44)];
	_whatEverButton.backgroundColor = [MaUtility getRandomColor];
	[_whatEverButton addTarget:self action:@selector(popDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_whatEverButton];	
}

-(void)popDropDownMenu:(id)sender
{
	MaPopupMenuController *controller = [[MaPopupMenuController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
	
	_popover = [[FPPopoverController alloc] initWithViewController:controller];
    _popover.tint = FPPopoverLightGrayTint;
	_popover.border = NO;
    _popover.contentSize = CGSizeMake(160, 300);
    _popover.arrowDirection = FPPopoverMaCustom;
    CGPoint point = ((UIButton*)sender).frame.origin;
	NSLog(@"Pop up menu from point %@",NSStringFromCGPoint(point));

    [_popover presentPopoverFromPoint: point];    
}




/*

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
    
    NSArray* subViewArray =  [dropDownMenuView subviews];
    for (UIView* theSubView in subViewArray) {
        if (theSubView.tag == 1919101910)
        { // #define DIM_VIEW_TAG 1919101910  == the dim view was defined in ADDropDownMenuView.m
            NSLog(@"%@", @"dimView found");
            theSubView.backgroundColor = [UIColor clearColor];
            }
    }
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

*/
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
