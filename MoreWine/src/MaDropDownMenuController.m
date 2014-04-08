//
//  MaDropDownMenuController.m
//  MoreWine
//
//  Created by Thunder on 4/3/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MaDropDownMenuController.h"
#import "MaTouchView.h"
#import "MaUtility.h"
#import "ShakeViewController.h"

@interface MaDropDownMenuController ()

@end

@implementation MaDropDownMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if(self)
    {
        _baseViewController = viewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSourceArray = [[NSArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, 300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor darkGrayColor];
    _touchView = [[UIView alloc] initWithFrame: self.view.bounds];
    _touchView.backgroundColor = [UIColor clearColor];
    _touchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _touchView.clipsToBounds = NO;

	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentPopoverFromPoint:(CGPoint)point
{
 //   NSLog(@"%@",@"popFromDMController");
    [self.view addSubview:_touchView];
    [self setupTouchViewTap:_touchView];
//    CGRect frame = CGRectMake(point.x, point.y+44, _tableView.frame.size.width, _tableView.frame.size.height);
//    _tableView.frame = frame;
//    NSLog(@"Present TableView from %@",NSStringFromCGRect(frame));
    [self showTableViewWithAnimationFromPoint:(point)];
}


-(void)showTableViewWithAnimationFromPoint:(CGPoint)point;
{
    CGRect currentFrame = CGRectMake(point.x, point.y, 160, 0);
    CGRect toFrame = CGRectMake(point.x, point.y, 160, 300);
    _tableView.frame = currentFrame;
    [self.view addSubview:_tableView];

    [UIView animateWithDuration:0.1f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _tableView.frame = toFrame;
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)setupTouchViewTap:(UIView*)view
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewTap:)];
	singleTap.numberOfTapsRequired = 1;
	[view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:singleTap];
}

-(void)touchViewTap:(id)sender
{
    NSLog(@"%@",@"handle dissmiss touch");
//    [_baseViewController dismissDropDownMenu];
    [self dismissTableView];
//    [((ShakeViewController*)_baseViewController) dismissDropDownMenuWithSelection:nil];
}

-(void)dismissTableView;
{
    [UIView animateWithDuration:0.2f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _tableView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [((ShakeViewController*)_baseViewController) dismissDropDownMenuWithSelection:nil];
                     }];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",@"handle didSelectRowAtIndexPath touch, and dismiss");
    [UIView animateWithDuration:0.2f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _tableView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [((ShakeViewController*)_baseViewController) dismissDropDownMenuWithSelection:indexPath];
                     }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell* cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.text = @"TEST";
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		[self addCheckMark:cell];
		
    }
    if (indexPath.row == 0) {
        cell.backgroundColor = [MaUtility getRandomColor];
        
    }
    
    return cell;
}

-(void)addCheckMark:(UITableViewCell*)theCell
{
    UIImageView *checkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(129, 15, 14, 14)];
    checkImageView.image=[UIImage imageNamed:@"shakeView_Cell_Selected"];
    [theCell addSubview:checkImageView];
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
