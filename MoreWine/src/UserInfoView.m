//
//  UserInfoView.m
//  MoreWine
//
//  Created by Thunder on 4/10/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "UserInfoView.h"
#import "MaUtility.h"

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
	_headerView.backgroundColor = [MaUtility getRandomColor];
	CALayer *imageLayer = _headerView.layer;
    [imageLayer setCornerRadius:48];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    _headerView.image = [UIImage imageNamed:@"loginView_default_user_icon"];
    [self addSubview:_headerView];

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 16)];
    _nameLabel.backgroundColor = [MaUtility getRandomColor];
    _nameLabel.font = [UIFont systemFontOfSize:16.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"MoreCafe";
    [self addSubview:_nameLabel];
    
    UIView* buttonView = [[UIView alloc ] initWithFrame:CGRectMake(0, 181, 320, 50)];
/*    UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    topLine.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.1];
    UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.1];
    UIView* midLine = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 1, 50)];
    midLine.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.1];
 //    [buttonView addSubview:topLine];
 //    [buttonView addSubview:bottomLine];
 //    [buttonView addSubview:midLine];
*/
    _checkInStatusButton = [self setupButtonByFrame:CGRectMake(0, 0, 160, 50) name:[self checkInButtonTitle]];
    [buttonView addSubview:_checkInStatusButton];

    _favoritStatusButton = [self setupButtonByFrame:CGRectMake(160, 0, 160, 50) name:[self favoriteButtonTitle]];
    [buttonView addSubview:_favoritStatusButton];

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
	theButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    theButton.layer.cornerRadius=0.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 0.7f;

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

-(void)checkInDetails
{

}

-(void)favoriteDetails
{

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
