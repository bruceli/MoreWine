//
//  UserInfoView.m
//  MoreWine
//
//  Created by Thunder on 4/10/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "UserInfoView.h"
#import "MaUtility.h"
#import "LoginViewController.h"

@implementation UserInfoView
@synthesize loginController = _loginController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.alwaysBounceVertical = YES;
//		CGSize scrollableSize = CGSizeMake(0, 455);
//      [self setContentSize:scrollableSize];
        [self setupViews];
    }
    return self;
}

-(void)setupViews
{
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(112, 37, 96, 96)];
	_headerView.backgroundColor = [UIColor clearColor];
	CALayer *imageLayer = _headerView.layer;
    [imageLayer setCornerRadius:48];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    _headerView.image = [UIImage imageNamed:@"loginView_default_user_icon"];
    [self addSubview:_headerView];

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 16)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:16.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"MoreCafe";
    [self addSubview:_nameLabel];
    
    UIView* buttonView = [[UIView alloc ] initWithFrame:CGRectMake(0, 181, 320, 150)];

    _checkInStatusButton = [self setupButtonByFrame:CGRectMake(0, 0, 320, 50) name:[self checkInButtonTitle]];
	[_checkInStatusButton addTarget:self action:@selector(checkInDetails:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_checkInStatusButton];

    _favoritStatusButton = [self setupButtonByFrame:CGRectMake(0, 49, 320, 50) name:[self favoriteButtonTitle]];
	[_favoritStatusButton addTarget:self action:@selector(favoriteDetails:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_favoritStatusButton];

	
    _tagButton = [self setupButtonByFrame:CGRectMake(0, 99, 320, 50) name:@"我的标签"];
	[_tagButton addTarget:self action:@selector(tagDetails:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_tagButton];

	
	// change buttonView frame before add buttons
    [self addSubview:buttonView];
}

-(NSString*)checkInButtonTitle
{
    return @"签到：32";
}

-(NSString*)favoriteButtonTitle
{
    return @"收藏：32";
}

-(UIButton*)setupButtonByFrame:(CGRect)theFrame name:(NSString*)name
{
	UIButton* theButton = [[UIButton alloc] initWithFrame:theFrame];
	theButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    theButton.layer.cornerRadius=0.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 0.7f;
    theButton.titleEdgeInsets = UIEdgeInsetsMake(5, 15, 0, 170);
	[theButton setTitle:name forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];

	return theButton;
}

-(void)buttonHighlight:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    theButton.layer.cornerRadius=0.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 2.0f;
}

-(void)buttonNormal:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor clearColor];
    theButton.layer.cornerRadius=0.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 0.7f;
}

-(void)checkInDetails:(id)sender
{
	[_loginController pushCheckInDetailController];
}

-(void)favoriteDetails:(id)sender
{
	[_loginController pushFavoriteDetailController];
}

-(void)tagDetails:(id)sender
{
	[_loginController pushTagDetailController];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
