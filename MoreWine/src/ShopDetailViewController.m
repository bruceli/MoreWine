//
//  ShopDetailViewController.m
//  MoreWine
//
//  Created by Thunder on 3/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShopDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

#import "MaUtility.h"
#import "AppDelegate.h"

#import "SGFocusImageItem.h"
#import "StyleIndicatorView.h"
#import "CheckInAndShareViewController.h"
#import "ShakeViewController.h"
#import "MaTagButton.h"
#import "MaNavigationBar.h"

@interface DetailNameView : UIView
{
	UIImageView* _headerImageView;
    UILabel* _nameLabel;
	UILabel* _nameSubTitleLabel;
    UILabel* _name;
    UILabel* _discriptionLable;
	UILabel* _consumptionLabel;
	StyleIndicatorView* _indicatorView;
}
-(void)setDiscriptions:(NSDictionary*)dict;

@end

@implementation DetailNameView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self initHeaderImageView];
		[self initShopNameLable];
		[self initConsumptionLable];
		[self initIndicatorView];
		
		UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(17, 120, 286, 1)];
		bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
		[self addSubview:bottomLineView];
	}
	return self;
}

-(void)initHeaderImageView
{
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 17, 93, 93)];
	_headerImageView.backgroundColor = [UIColor clearColor];
    
    CALayer *imageLayer = _headerImageView.layer;
    [imageLayer setCornerRadius:45];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    [self addSubview:_headerImageView];	
}

-(void)initShopNameLable
{
	_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 17, 171, 21)];
	_nameLabel.backgroundColor = [UIColor clearColor];
	_nameLabel.font = [UIFont systemFontOfSize:21.0f];
	_nameLabel.textColor = [UIColor whiteColor];
	[self addSubview:_nameLabel];
	
	_nameSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 54, 171, 14)];
	_nameSubTitleLabel.backgroundColor = [UIColor clearColor];
	_nameSubTitleLabel.font = [UIFont systemFontOfSize:14.0f];
	_nameSubTitleLabel.textColor = [UIColor whiteColor];
	[self addSubview:_nameSubTitleLabel];
	
	UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(127, 71, 176, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[self addSubview:bottomLineView];
}

-(void)initConsumptionLable
{
	UILabel* consumptionName = [[UILabel alloc] initWithFrame:CGRectMake(127, 88, 48, 14)];
	consumptionName.backgroundColor = [UIColor clearColor];
	consumptionName.font = [UIFont systemFontOfSize:14.0f];
	consumptionName.textColor = [UIColor whiteColor];
	consumptionName.text = NSLocalizedString(@"MA_MoreWine_ShopDetailView_Consumption", nil);
	[self addSubview:consumptionName];

	_consumptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 88, 48, 14)];
	_consumptionLabel.backgroundColor = [UIColor clearColor];
	_consumptionLabel.font = [UIFont systemFontOfSize:14.0f];
	_consumptionLabel.textColor = [UIColor whiteColor];
	[self addSubview:_consumptionLabel];
}

-(void)initIndicatorView
{
    CGRect frame = CGRectMake(175+48+5, 88, 70, 14);
    _indicatorView = [[StyleIndicatorView alloc] initStyleIndicatorViewWithFrame:frame ByDict:nil];
    [self addSubview:_indicatorView];
}


-(void)setDiscriptions:(NSDictionary*)dict
{
	_nameLabel.text = @"MORE CAFÉ";
	_nameSubTitleLabel.text = @"摩尔咖啡馆";
	_consumptionLabel.text = @"¥39";
	
	[self setHeaderImage];
}

-(void)setHeaderImage
{
	int r = arc4random() % 4;
	NSString *noString = [NSString stringWithFormat:@"%d",r];
	NSMutableString* imageNameString = [NSMutableString stringWithString:noString];
	[imageNameString appendString:@"headerImage.png"];
    //	NSLog(@"%@",imageNameString);
	UIImage* img = [UIImage imageNamed:imageNameString];
	_headerImageView.image = img;
}
@end


@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController

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
	//blurImageView
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];    
	_bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	_bkgBlurImageView.image = image;
    [self.view addSubview:_bkgBlurImageView];
	
	_scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
	_scrollView.backgroundColor = [UIColor clearColor];
	_scrollView.alwaysBounceVertical = YES;
	[self.view addSubview:_scrollView];
	
	[self setupHilightImageView];
	[_scrollView addSubview:_hilightImageView];
	
	_detailNameView = [[DetailNameView alloc] initWithFrame:CGRectMake(0, 154, 320, 120)];
	[_scrollView addSubview:_detailNameView];
	
	[self setupAddressView];
	[self setupTelView];
	[self setupTagView];
	[self setupShakeButtonView];
	[self setupCheckInView];
    
	[self fillInfo];
	//setupShakeButtonView CGRectMake(17, 528, 286, 30)
	_scrollView.contentSize = CGSizeMake(320,533+30+64+64);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAddressView
{
	UIView* addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 274, 320, 40)];
	addressView.backgroundColor = [UIColor clearColor];
	
	UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 13, 14, 14)];
	imgView.backgroundColor = [UIColor clearColor];
	imgView.image = [UIImage imageNamed:@"barType_music.png"];
	[addressView addSubview:imgView];
	
	UILabel* addLabelName = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 50, 14)];
	addLabelName.backgroundColor = [UIColor clearColor];
	addLabelName.font = [UIFont systemFontOfSize:14.0f];
	addLabelName.textColor = [UIColor whiteColor];
	addLabelName.text = NSLocalizedString(@"MA_MoreWine_ShopDetailView_Address", nil);
	addLabelName.backgroundColor = [UIColor clearColor];

	_addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 13, 211, 14)];
	_addressLabel.backgroundColor = [UIColor clearColor];
	_addressLabel.font = [UIFont systemFontOfSize:14.0f];
	_addressLabel.textColor = [UIColor whiteColor];

	[addressView addSubview:addLabelName];
	[addressView addSubview:_addressLabel];

	//UILabel* _addressLabel;
//	UILabel* _telLabel;

	
	UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(17, 40, 286, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[addressView addSubview:bottomLineView];
	
	[_scrollView addSubview:addressView];
}

-(void)setupTelView
{
	UIView* telView = [[UIView alloc] initWithFrame:CGRectMake(0, 314, 320, 40)];
	telView.backgroundColor = [UIColor clearColor];
	
	UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 13, 14, 14)];
	imgView.backgroundColor = [UIColor clearColor];
	imgView.image = [UIImage imageNamed:@"barType_music.png"];
	[telView addSubview:imgView];
	
	UILabel* telLabelView = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 50, 14)];
	telLabelView.backgroundColor = [UIColor clearColor];
	telLabelView.font = [UIFont systemFontOfSize:14.0f];
	telLabelView.textColor = [UIColor whiteColor];
	telLabelView.text = NSLocalizedString(@"MA_MoreWine_ShopDetailView_Tel", nil);
	telLabelView.backgroundColor = [UIColor clearColor];
	
	_telLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 13, 211, 14)];
	_telLabel.backgroundColor = [UIColor clearColor];
	_telLabel.font = [UIFont systemFontOfSize:14.0f];
	_telLabel.textColor = [UIColor whiteColor];
	
	[telView addSubview:telLabelView];
	[telView addSubview:_telLabel];

	UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(17, 40, 286, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[telView addSubview:bottomLineView];
	
	[_scrollView addSubview:telView];
}

-(void)setupTagView
{
	UIView* tagView = [[UIView alloc] initWithFrame:CGRectMake(0, 354, 320, 108)];
	tagView.backgroundColor = [UIColor clearColor];
	
	UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 14, 14)];
	imgView.backgroundColor = [UIColor clearColor];
	imgView.image = [UIImage imageNamed:@"barType_music.png"];
	[tagView addSubview:imgView];
	
	UILabel* telLabelView = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, 50, 14)];
	telLabelView.backgroundColor = [UIColor clearColor];
	telLabelView.font = [UIFont systemFontOfSize:14.0f];
	telLabelView.textColor = [UIColor whiteColor];
	telLabelView.text = NSLocalizedString(@"MA_MoreWine_ShopDetailView_Tag", nil);
	telLabelView.backgroundColor = [UIColor clearColor];
	[tagView addSubview:telLabelView];

	[self setupTagsIn:tagView];
    
    UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(17, 108, 286, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[tagView addSubview:bottomLineView];

	
	[_scrollView addSubview:tagView];
}

-(void)setupTagsIn:(UIView*)tagView
{
	UILabel* tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 38, 68, 22)];
	tagLabel.layer.cornerRadius = 10.0;
	tagLabel.layer.masksToBounds = YES;
	tagLabel.backgroundColor = [MaUtility getRandomColor];
	[tagView addSubview:tagLabel];
	
	MaTagButton *tagButton = [[MaTagButton alloc] initWithFrame:CGRectMake(85, 38, 68, 28)];
	[tagButton setTitle:@"测试按钮" forState:UIControlStateNormal];
	tagButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];
	[tagView addSubview:tagButton];
	
	UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(153, 38, 68, 22)];
	testButton.layer.cornerRadius=9.0f;
    testButton.layer.masksToBounds=YES;
    testButton.layer.borderColor=[[UIColor whiteColor]CGColor];
    testButton.layer.borderWidth= 0.7f;
	[testButton setTitle:@"测试按钮" forState:UIControlStateNormal];
	testButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];

	[tagView addSubview:testButton];

}

-(void)setupShakeButtonView
{
//	UIView* shakeButtonView = [[UIView alloc] initWithFrame:CGRectMake(17, 537, 286, 30)];
//	shakeButtonView.backgroundColor = [UIColor clearColor];
	
	UIButton *shakeButton = [[UIButton alloc] initWithFrame:CGRectMake(17, 473, 286, 40)];
    [shakeButton addTarget:self action:@selector(shake:) forControlEvents:UIControlEventTouchUpInside];
    [shakeButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[shakeButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[shakeButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];

	shakeButton.layer.cornerRadius=4.0f;
    shakeButton.layer.masksToBounds=YES;
    shakeButton.layer.borderColor=[[UIColor whiteColor]CGColor];
    shakeButton.layer.borderWidth= 0.7f;
	[shakeButton setTitle:@"Shake!!" forState:UIControlStateNormal];
	shakeButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    
	[_scrollView addSubview:shakeButton];
}

-(void)setupCheckInView
{
	UIButton *checkIn = [[UIButton alloc] initWithFrame:CGRectMake(17, 523, 286, 40)];
    [checkIn addTarget:self action:@selector(checkIn:) forControlEvents:UIControlEventTouchUpInside];
    [checkIn addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[checkIn addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[checkIn addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];

	checkIn.layer.cornerRadius=4.0f;
    checkIn.layer.masksToBounds=YES;
    checkIn.layer.borderColor=[[UIColor whiteColor]CGColor];
    checkIn.layer.borderWidth= 0.7f;
	[checkIn setTitle:@"签到" forState:UIControlStateNormal];
	checkIn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    
	[_scrollView addSubview:checkIn];
}


-(void)setupHilightImageView
{
	//    _hilightImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, TableView_HeaderView_Height)];
    
//	AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    /*
     if ([app.dataSettingMgr.hilightDataArray count]<1) {
     [self loadSlides];
     return;
     }
     */
	NSMutableArray* _scrollingArray = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
	
	NSMutableArray* scrItemArray = [[NSMutableArray alloc] init];
	if( [_scrollingArray count]>0){
		for (int i = 0; i < [_scrollingArray count] ; i++) {
            //  NSDictionary* dict = [_scrollingArray objectAtIndex:i];
			//            NSLog(@"Item %d,%@", i,dict);
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"title" image:@"" targetURL:@""  tag:i];
			NSLog(@"%@",@"create SGFocusImageItem");
            //	SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:[[dict objectForKey:@"title"] URLDecodedString] image:[[dict objectForKey:@"smallimg"] URLDecodedString] targetURL:[[dict objectForKey:@"link"] URLDecodedString]  tag:i];
			[scrItemArray addObject:item];
		}
	}
	SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, 320, 154) delegate:self focusImageItemArray:scrItemArray];
    _hilightImageView = imageFrame;
}

-(void)fillInfo
{
	[_detailNameView setDiscriptions:nil];
	_addressLabel.text = @"解放路77号";
	_telLabel.text = @"029-99999999";
}

-(void)checkIn:(id)sender
{
    // Orignal 
	CheckInAndShareViewController* controller = [[CheckInAndShareViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
	[navController setViewControllers:@[controller]];
	[self presentViewController:navController animated:YES completion:nil];	

	// blur style
//	CheckInAndShareViewController* controller = [[CheckInAndShareViewController alloc] init];
//	[controller showOnViewController:self];
	

}

-(void)popCheckInView
{
	[UIView animateWithDuration:0.5 animations:^{
     //   BOOL open = self.blurView.frame.size.height > 200;
       // self.blurView.frame = CGRectMake(0, open? 568: 143, 320, open? 0: 425);
    }];
}

-(void)shake:(id)sender
{
    ShakeViewController* viewController = [[ShakeViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
}

-(void)buttonHighlight:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
	theButton.layer.cornerRadius=4.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 2.0f;
}

-(void)buttonNormal:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor clearColor];
	theButton.layer.cornerRadius=4.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 1.0f;
}


#pragma mark - SGFocusImageFramedelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%@ ", @"FocusImage tap");
    //    NSString* urlString = [item.targetURL URLDecodedString ];
    
    //    [self.navigationController pushViewController: bbsViewController animated:YES];
}


@end
