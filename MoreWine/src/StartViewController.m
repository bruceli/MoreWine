//
//  StartViewController.m
//  MoreWine
//
//  Created by Thunder on 3/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "StartViewController.h"

typedef NS_ENUM(NSInteger, StartViewButtonType) {
    Ma_StartView_HomeButton = 0,
	Ma_StartView_RecommendButton,    
	Ma_StartView_CheckInButton,   
	Ma_StartView_CamButton,
	Ma_StartView_UserButton
};                

@interface StartViewController ()

@end

@implementation StartViewController

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
	self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
	_buttonArray = [[NSMutableArray alloc] init];
	[self setupButtons];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupButtons
{
	UIButton* theButton;
	_buttonGroupView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 60, 368)];
	_buttonGroupView.center = self.view.center;
	for(NSInteger i = Ma_StartView_HomeButton; i <= Ma_StartView_UserButton; i++)
	{
//		NSLog(@"create button no. %ld", (long)i);		
		theButton = [UIButton buttonWithType:UIButtonTypeCustom];
		theButton.tag = i;
		CGRect frame = CGRectMake(0, i*77, 60, 60);// button height + gap = 77
		theButton.frame = frame;
		theButton.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
		[_buttonGroupView addSubview:theButton];
		[_buttonArray addObject:theButton];
		[theButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
		
//		- (void)setBackgroundImage:(UIImage *)image forState:	(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil		
//		- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
	}
	[self.view addSubview:_buttonGroupView];
}

-(void)buttonAction:(UIButton*)sender
{
	switch(sender.tag)
	{
		case Ma_StartView_HomeButton:
			NSLog(@"%@",@"Ma_StartView_HomeButton");
			break;
			
		case Ma_StartView_RecommendButton:
			NSLog(@"%@",@"Ma_StartView_RecommendButton");
			break;
			
		case Ma_StartView_CheckInButton:
			NSLog(@"%@",@"Ma_StartView_CheckInButton");
			break;
			
		case Ma_StartView_CamButton:
			NSLog(@"%@",@"Ma_StartView_CamButton");
			break;

		case Ma_StartView_UserButton:
			NSLog(@"%@",@"Ma_StartView_UserButton");
			break;

		default:
			;
	}
}

@end
