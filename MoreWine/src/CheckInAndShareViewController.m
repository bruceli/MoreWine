//
//  CheckInAndShareViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "CheckInAndShareViewController.h"
//#import "UIBarButtonItem+StyledButton.h"
#import "FXBlurView.h"
#import "MaUtility.h"

@interface CheckInAndShareViewController ()

@end

@implementation CheckInAndShareViewController
@synthesize blurView = _blurView;

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

    NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];
	UIImageView* _bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	_bkgBlurImageView.image = image;
    [self.view addSubview:_bkgBlurImageView];
    

    
	_baseView = [[UIView alloc] initWithFrame:self.view.bounds];
	_baseView.backgroundColor = [UIColor clearColor];
	
	[self setupBlurView];
	[self setupNavBarItems];
	[self setupTextView];
    [self setupShareView];  
	
	[self.view addSubview:_baseView];
    // Do any additional setup after loading the view.
}

//http://cases.azoft.com/ios7-like-dynamic-blur-effect-using-fxblurview/
- (void)showOnViewController:(UIViewController *)vc {  
    _parentVC = vc;  
    [_parentVC addChildViewController:self];  
	
    _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];  
    _blurView.underlyingView = vc.view;  
    _blurView.tintColor = [UIColor clearColor];  
    _blurView.updateInterval = 1;  
    _blurView.blurRadius = 10.f;  
    _blurView.alpha = 0.f;  
    _blurView.frame = vc.view.bounds;  
	
    [_parentVC.view addSubview:_blurView];  
    [_parentVC.view addSubview:self.view];  
	
    self.view.backgroundColor = [UIColor clearColor];  
    self.view.alpha = 0.f;  
    self.view.frame = vc.view.bounds;  
	
    [UIView animateWithDuration:0.1 animations:^{  
        _blurView.alpha = 1.f;  
    } completion:^(BOOL finished) {  
        [UIView animateWithDuration:0.1 animations:^{  
            self.view.alpha = 1.0f;  
        }];  
    }];  
}  


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupBlurView
{
    _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];  
    _blurView.underlyingView = _parentVC.view;  
    _blurView.tintColor = [UIColor clearColor];  
    _blurView.updateInterval = 1;  
    _blurView.blurRadius = 10.f;  
    _blurView.alpha = 0.f;  
    _blurView.frame = _parentVC.view.bounds;  
	[self.view addSubview:_blurView];
}

-(void)setupTextView
{
//	self.view.backgroundColor = [MaUtility getRandomColor];
    _infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, 320, 155)];
    _infoTextView.backgroundColor = [UIColor darkGrayColor];
    _infoTextView.contentInset = UIEdgeInsetsMake(-64.0f, 10.0f, 0.0f ,10.0f);
    _infoTextView.font = [UIFont systemFontOfSize:18.0f];
    _infoTextView.textColor = [UIColor whiteColor];
    _infoTextView.textAlignment = NSTextAlignmentLeft;
	//    [self.view addSubview:_infoTextView];
	[_baseView addSubview:_infoTextView];
}

-(void)setupNavBarItems
{
    UIImage *backImage = [UIImage imageNamed:@"navigation_Back_Icon"];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, backImage.size.width, backImage.size.height)];
	button.backgroundColor = [MaUtility getRandomColor];
	[button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:backImage forState:UIControlStateNormal];
	//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	negativeSpacer.width = -16;// it was -6 in iOS 6
	[self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:button]/*this will be the button which u actually need*/, nil] animated:NO];
}

-(void)setupShareView
{
    UIView* shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+155, 320, 60)];
    UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
	topLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[shareView addSubview:topLineView];
    
    UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[shareView addSubview:bottomLineView];
    
    UIImageView* shareIconView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 23, 14, 14)];
    shareIconView.backgroundColor = [UIColor clearColor];
    [shareView addSubview:shareIconView];
    
    UILabel* shareToLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 23, 47, 14)];
    shareToLabel.font = [UIFont systemFontOfSize:14.0f];
    shareToLabel.textColor = [UIColor whiteColor];
    shareToLabel.backgroundColor = [UIColor clearColor];
    shareToLabel.text = @"分享到:";
    [shareView addSubview:shareToLabel];
    
	UIButton* weChatButton = [[UIButton alloc] initWithFrame:CGRectMake(109, 8, 44, 44)];
	weChatButton.backgroundColor = [UIColor clearColor];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat_hilight"] forState:UIControlStateSelected];
	[shareView addSubview:weChatButton];
    
	UIButton* weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(161, 8, 44, 44)];
	weiboButton.backgroundColor = [UIColor clearColor];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo_hilight"] forState:UIControlStateSelected];
	[shareView addSubview:weiboButton];
    
//    [self.view addSubview:shareView];
	[_baseView addSubview:shareView];

}

-(void)cancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)share
{

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
