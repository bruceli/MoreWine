//
//  ShakeViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShakeViewController.h"
#import "MaUtility.h"
#import "MaDropDownMenuController.h"
#import "ShakeResultViewController.h"

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
    //self.view.backgroundColor = [UIColor clearColor];
	//blurImageView
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];    
	UIImageView* _bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	_bkgBlurImageView.image = image;
    [self.view addSubview:_bkgBlurImageView];

	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height)];
	_scrollView.backgroundColor = [UIColor clearColor];
	_scrollView.alwaysBounceVertical = YES;
	_scrollView.contentSize = CGSizeMake(320, 455);
	[self.view addSubview:_scrollView];
	
    [self setupHeaderViews];
    [self setupDropDownMenus];
	[self setupShakeButtonView];
	[self setupRecommedTitleView];
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
/*    _baseLiqButton = [self setupButtonByFrame:CGRectMake(0, 64, 160, 44)];
	[self setupButton:_baseLiqButton title:@"基酒"];
	[self addRightEdge:_baseLiqButton];
	
	_tastButton = [self setupButtonByFrame:CGRectMake(0, 108, 160, 44)];
	[self setupButton:_tastButton title:@"口味"];
	[self addRightEdge:_tastButton];

    _tempButton = [self setupButtonByFrame:CGRectMake(0, 152, 160, 44)];
	[self setupButton:_tempButton title:@"温度"];
	[self addRightEdge:_tempButton];

    _keyWordsButton = [self setupButtonByFrame:CGRectMake(0, 196, 160, 44)];
	[self setupButton:_keyWordsButton title:@"关键字"];
	[self addRightEdge:_keyWordsButton];
	[self addBottonEdge:_keyWordsButton];

    _alcoholButton = [self setupButtonByFrame:CGRectMake(160, 64, 160, 44)];
	[self setupButton:_alcoholButton title:@"酒精度"];

    _typeButton = [self setupButtonByFrame:CGRectMake(160, 108, 160, 44)];
	[self setupButton:_typeButton title:@"类型"];

	_colorButton = [self setupButtonByFrame:CGRectMake(160, 152, 160, 44)];
	[self setupButton:_colorButton title:@"颜色"];
	
	_whatEverButton = [self setupButtonByFrame:CGRectMake(160, 196, 160, 44)];
	[self setupButton:_whatEverButton title:@"随便"];
	[self addBottonEdge:_whatEverButton];
 */
	_baseLiqButton = [self setupButtonByFrame:CGRectMake(0, 0, 160, 44)];
	[self setupButton:_baseLiqButton title:@"基酒"];
	[self addRightEdge:_baseLiqButton];
	
	_tastButton = [self setupButtonByFrame:CGRectMake(0, 44, 160, 44)];
	[self setupButton:_tastButton title:@"口味"];
	[self addRightEdge:_tastButton];
	
    _tempButton = [self setupButtonByFrame:CGRectMake(0, 88, 160, 44)];
	[self setupButton:_tempButton title:@"温度"];
	[self addRightEdge:_tempButton];
	
    _keyWordsButton = [self setupButtonByFrame:CGRectMake(0, 132, 160, 44)];
	[self setupButton:_keyWordsButton title:@"关键字"];
	[self addRightEdge:_keyWordsButton];
	[self addBottonEdge:_keyWordsButton];
	
    _alcoholButton = [self setupButtonByFrame:CGRectMake(160, 0, 160, 44)];
	[self setupButton:_alcoholButton title:@"酒精度"];
	
    _typeButton = [self setupButtonByFrame:CGRectMake(160, 44, 160, 44)];
	[self setupButton:_typeButton title:@"类型"];
	
	_colorButton = [self setupButtonByFrame:CGRectMake(160, 88, 160, 44)];
	[self setupButton:_colorButton title:@"颜色"];
	
	_whatEverButton = [self setupButtonByFrame:CGRectMake(160, 132, 160, 44)];
	[self setupButton:_whatEverButton title:@"随便"];
	[self addBottonEdge:_whatEverButton];

}

-(void)setupShakeButtonView
{
	_shakeButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 216, 124, 124)];
	_shakeButton.backgroundColor = [UIColor clearColor];

	[_shakeButton addTarget:self action:@selector(pushShakeResult:) forControlEvents:UIControlEventTouchUpInside];
	[_shakeButton setImage:[UIImage imageNamed:@"shakeView_shakeButton"] forState:UIControlStateNormal];
	[_shakeButton setImage:[UIImage imageNamed:@"shakeView_shakeButton_hilight"] forState:UIControlStateSelected];
	[_scrollView addSubview:_shakeButton];
}

-(void)pushShakeResult:(id)sender
{
	//ShakeResultViewController
	ShakeResultViewController* viewController = [[ShakeResultViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];

}

-(void)setupRecommedTitleView
{
	UIView* theView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 24)];

	UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(17, 0, 286, 1)];
	topLine.backgroundColor = [UIColor whiteColor];
	[theView addSubview:topLine];

	UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(17, 24, 286, 1)];
	bottomLine.backgroundColor = [UIColor whiteColor];
	[theView addSubview:bottomLine];

	UILabel* theLable = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 286, 24)];
	theLable.backgroundColor = [UIColor clearColor];
	theLable.text = @"不知道喝什么？ 选择您喜欢的类型，让我为您推荐！";
	theLable.font = [UIFont systemFontOfSize:11];
	theLable.textColor = [UIColor whiteColor];
	[theView addSubview:theLable];
	
	[_scrollView addSubview:theView];
}

-(UIButton*)setupButtonByFrame:(CGRect)frame
{
    UIButton* theButton = [[UIButton alloc]initWithFrame:frame];
    theButton.backgroundColor = [UIColor clearColor];
	[theButton addTarget:self action:@selector(popMaMenu:) forControlEvents:UIControlEventTouchUpInside];
	[_scrollView addSubview:theButton];
    return theButton;
}

-(void)addRightEdge:(UIButton*)theButton
{
	UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 1, 44)];
	rightLine.backgroundColor = [UIColor whiteColor];
	[theButton addSubview:rightLine];
}

-(void)addBottonEdge:(UIButton*)theButton
{
	UIView* bottonLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 160, 1)];
	bottonLine.backgroundColor = [UIColor whiteColor];
	[theButton addSubview:bottonLine];
}

-(void)setupButton:(UIButton*)theButton title:(NSString*)theTitle
{
	//- (void)setTitle:(NSString *)title forState:(UIControlState)state;                     // default is nil. title is assumed to be single line
	UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 1)];
	topLine.backgroundColor = [UIColor whiteColor];
	[theButton addSubview:topLine];
	
	[theButton setTitle:theTitle forState:UIControlStateNormal];
	theButton.titleLabel.font = [UIFont systemFontOfSize:14];
	theButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	theButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	
	[theButton setImage:[UIImage imageNamed:@"shakeMenuArrow"] forState:UIControlStateNormal];
	[theButton setImageEdgeInsets:UIEdgeInsetsMake(0, 119, 0, 0)];	
}

-(void)popMaMenu:(id)sender
{
 	_dropDownController = [[MaDropDownMenuController alloc] initWithViewController:self];
    //    controller.delegate = self;
//	CGPoint point = ((UIButton*)sender).frame.origin;
//	NSLog(@"sender from point %@",NSStringFromCGPoint(point));

//	CGPoint thePoint = [self.view convertPoint:((UIButton*)sender).frame.origin toView:_scrollView];
//	CGPoint thePoint = _scrollView.contentOffset;
//	NSLog(@"contentOffect %@",NSStringFromCGPoint(thePoint));

    [self.view addSubview:_dropDownController.view];
    [self addChildViewController:_dropDownController];
    [self didMoveToParentViewController:self];
    
	CGPoint popPoint = CGPointMake(((UIButton*)sender).frame.origin.x, ((UIButton*)sender).frame.origin.y-_scrollView.contentOffset.y+44);// +44 pop menu from bottom of menu;
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
