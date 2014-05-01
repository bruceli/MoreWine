//
//  MaDropDownMenuController.m
//  MoreWine
//
//  Created by Thunder on 4/3/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MaDropDownMenuController.h"
#import "MaUtility.h"
#import "ShakeViewController.h"
#import "FXBlurView.h"

@interface MaDropDownMenuController ()

@end

@implementation MaDropDownMenuController
@synthesize menuWidth = _menuWidth;
@synthesize aligment = _aligment;

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
        _menuWidth = 320;
        _baseViewController = viewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSourceArray = [[NSArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _menuWidth, 300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
	
//	_blurView = [[FXBlurView alloc] initWithFrame:_tableView.frame];
//	_blurView.backgroundColor = [UIColor yellowColor];

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
    CGFloat xPoint;
    if (_aligment == MA_DropDownMenuAlignment_Self)
        xPoint = point.x;
    else
        xPoint = 0;
    
    CGRect currentFrame = CGRectMake(xPoint, point.y, _menuWidth, 0);
    CGRect toFrame = CGRectMake(xPoint, point.y, _menuWidth, 300);
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
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor colorWithRed:0.6f green:0.4f blue:0.2f alpha:0.7];
		//+ (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB 
        cell.textLabel.text = @"TEST";
        
        if (_aligment == MA_DropDownMenuAlignment_Self)
        {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            [self addCheckMark:cell];
        }
        else
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
		
    }
  
    return cell;
}


-(void)addCheckMark:(UITableViewCell*)theCell
{
    UIImageView *checkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(129, 15, 14, 14)];
    checkImageView.image=[UIImage imageNamed:@"shakeView_Cell_Selected"];
    [theCell addSubview:checkImageView];
}

@end
