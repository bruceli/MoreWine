//
//  ShakeResultViewController.m
//  MoreWine
//
//  Created by Thunder on 4/8/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShakeResultViewController.h"
#import "MaUtility.h"
#import "CheckInAndShareViewController.h"
#import "MaNavigationBar.h"

@interface ShakeResultViewController ()

@end

@implementation ShakeResultViewController

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
	
	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y+64, 320, self.view.frame.size.height-64)];
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];    
	UIImageView* _bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	_bkgBlurImageView.image = image;
    [self.view addSubview:_bkgBlurImageView];
	_scrollView.alwaysBounceVertical = YES;
	_scrollView.contentSize = CGSizeMake(320, 455+64);
	[self.view addSubview:_scrollView];

	[self setupViews];
	[self setupButtonView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViews
{
	UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	titleLabel.backgroundColor = [MaUtility getRandomColor];
	titleLabel.text = @"为您推荐";
	titleLabel.font = [UIFont systemFontOfSize:16.0f];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.textAlignment = NSTextAlignmentCenter;
	[_scrollView addSubview:titleLabel];
	
	_resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(92, 80, 136, 136)];
	_resultImageView.backgroundColor = [MaUtility getRandomColor];
	CALayer *imageLayer = _resultImageView.layer;
    [imageLayer setCornerRadius:66];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
	[_scrollView addSubview:_resultImageView];

	_resultNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 256, 286, 30)];
	_resultNameLabel.backgroundColor = [MaUtility getRandomColor];
	_resultNameLabel.text = @"黑色俄罗斯";
	_resultNameLabel.font = [UIFont systemFontOfSize:16.0f];
	_resultNameLabel.textColor = [UIColor whiteColor];
	_resultNameLabel.textAlignment = NSTextAlignmentLeft;
	[_scrollView addSubview:_resultNameLabel];

	
	UILabel* materialLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 294, 286, 14)];
	materialLabel.backgroundColor = [MaUtility getRandomColor];
	materialLabel.text = @"材料:";
	materialLabel.font = [UIFont systemFontOfSize:14.0f];
	materialLabel.textColor = [UIColor whiteColor];
	materialLabel.textAlignment = NSTextAlignmentLeft;
	[_scrollView addSubview:materialLabel];

	
	_materialDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 313, 286, 64)];
	_materialDetailLabel.backgroundColor = [UIColor clearColor];
    _materialDetailLabel.font = [UIFont systemFontOfSize:12.0f];
    _materialDetailLabel.text = @"宇宙中的一颗类地行星，上面有高度的文明，生活着拥有极高智慧的喵星人。";
	_materialDetailLabel.textAlignment = NSTextAlignmentLeft;
	_materialDetailLabel.numberOfLines = 0;
	_materialDetailLabel.textColor = [UIColor whiteColor];
	[_materialDetailLabel sizeToFit];
	[_scrollView addSubview:_materialDetailLabel];	
}

-(void)setupButtonView
{
	UIView* buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 377, 320, 50)];
	_favButton = [self setupButtonByFrame:CGRectMake(39, 26, 75, 30) name:@"收藏"];
	[_favButton addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
	[buttonView addSubview:_favButton];
	
	_shareButton = [self setupButtonByFrame:CGRectMake(121, 26, 75, 30) name:@"分享"];
	[_shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
	[buttonView addSubview:_shareButton];

	_oneMoreButton = [self setupButtonByFrame:CGRectMake(203, 26, 75, 30) name:@"再来一次"];
	[_oneMoreButton addTarget:self action:@selector(oneMore:) forControlEvents:UIControlEventTouchUpInside];
	[buttonView addSubview:_oneMoreButton];

	[_scrollView addSubview:buttonView];
}

-(UIButton*)setupButtonByFrame:(CGRect)theFrame name:(NSString*)name
{
	UIButton* theButton = [[UIButton alloc] initWithFrame:theFrame];
	theButton.layer.cornerRadius=15.0f;    
	theButton.layer.borderWidth= 0.7f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
	theButton.titleLabel.font = [UIFont systemFontOfSize:11.0f];

	[theButton setTitle:name forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];

	return theButton;
}

-(void)addFavorite:(id)sender
{

}

-(void)share:(id)sender
{
	[self buttonNormal:sender];
		
	CheckInAndShareViewController* controller = [[CheckInAndShareViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
	[navController setViewControllers:@[controller]];
	[self presentViewController:navController animated:YES completion:nil];	
}

-(void)oneMore:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)buttonHighlight:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
	theButton.layer.cornerRadius=15.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 2.0f;
}

-(void)buttonNormal:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor clearColor];
	theButton.layer.cornerRadius=15.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 0.7f;
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
