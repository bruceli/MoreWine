//
//  SignInView.m
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "SignInView.h"
#import "MaUtility.h"
#import "AppDelegate.h"
#import "UserInfoManager.h"
#import "LoginViewController.h"

#define MA_LoginView_Content_Height 455

@implementation SignInView
@synthesize loginController = _loginController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.alwaysBounceVertical = YES;	
		CGSize scrollableSize = CGSizeMake(0, MA_LoginView_Content_Height);
		[self setContentSize:scrollableSize];

		[self setupViews];
		[self setupButtons];
	}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setupViews
{
 /*   _touchView = [[UIView alloc] initWithFrame: self.bounds];
    _touchView.backgroundColor = [UIColor clearColor];
    _touchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _touchView.clipsToBounds = NO;
    [self setupTouchViewTap:_touchView];

*/
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tap];

    self.contentSize = CGSizeMake(0, MA_LoginView_Content_Height);
	
	self.backgroundColor = [UIColor clearColor];
	UIImageView* logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 183)];
	logoView.image = [UIImage imageNamed:@"loginView_logo"];
	[self addSubview:logoView];
	
	UILabel* loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 345, 140, 14)];
	loginLabel.backgroundColor = [UIColor clearColor];
	loginLabel.font = [UIFont systemFontOfSize:14.0f];
	loginLabel.textColor = [UIColor whiteColor];
	loginLabel.text = NSLocalizedString(@"MA_MoreWine_LoginView_3rdLogin", nil);
	[self addSubview:loginLabel];
}

-(void)setupButtons
{
    _nameField = [self setupFieldBy:CGRectMake(17, 183, 286, 40)];
	_nameField.returnKeyType = UIReturnKeyDone;
	_nameField.text = NSLocalizedString(@"MA_MoreWine_LoginView_UserName", nil);
	[self addSubview:_nameField];
    
    _pswField = [self setupFieldBy:CGRectMake(17, 228, 286, 40)];
	_pswField.returnKeyType = UIReturnKeyDone;
	_pswField.text = NSLocalizedString(@"MA_MoreWine_LoginView_Password", nil);
    [_pswField addTarget:self action:@selector(login:) forControlEvents:UIControlEventEditingDidEndOnExit];
	[self addSubview:_pswField];
	
    UIButton *singUpButton = [self setupButtonBy:CGRectMake(17, 278, 140, 40)];
	[singUpButton setTitle:NSLocalizedString(@"MA_MoreWine_LoginView_SignUp", nil) forState:UIControlStateNormal];
    [singUpButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:singUpButton];
	
	UIButton *singInButton = [self setupButtonBy:CGRectMake(163, 278, 140, 40)];
	[singInButton setTitle:NSLocalizedString(@"MA_MoreWine_LoginView_SignIn", nil)  forState:UIControlStateNormal];
    [singInButton addTarget:self action:@selector(singIn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:singInButton];
	
	UIButton* qqButton = [[UIButton alloc] initWithFrame:CGRectMake(79, 370, 44, 44)];
	qqButton.backgroundColor = [UIColor clearColor];
	[qqButton setBackgroundImage:[UIImage imageNamed:@"loginView_qq"] forState:UIControlStateNormal];
	[qqButton setBackgroundImage:[UIImage imageNamed:@"loginView_qq_hilight"] forState:UIControlStateSelected];
	[self addSubview:qqButton];

	UIButton* weChatButton = [[UIButton alloc] initWithFrame:CGRectMake(138, 370, 44, 44)];
	weChatButton.backgroundColor = [UIColor clearColor];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat_hilight"] forState:UIControlStateSelected];
	[self addSubview:weChatButton];

	UIButton* weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(197, 370, 44, 44)];
	weiboButton.backgroundColor = [UIColor clearColor];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo_hilight"] forState:UIControlStateSelected];
	[self addSubview:weiboButton];
}

-(UITextField*)setupFieldBy:(CGRect)frame
{
    UITextField* theField = [[UITextField alloc] initWithFrame:frame];
	theField.borderStyle = UITextBorderStyleNone;
	theField.backgroundColor = [UIColor clearColor];
    theField.layer.cornerRadius=4.0f;
    theField.layer.masksToBounds=YES;
    theField.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theField.layer.borderWidth= 1.0f;
	UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
	theField.leftView = namePaddingView;
	theField.leftViewMode = UITextFieldViewModeAlways;
	theField.delegate = self;
    theField.textColor = [UIColor lightGrayColor];

    return theField;
}

-(UIButton*)setupButtonBy:(CGRect)frame
{
    UIButton *theButton = [[UIButton alloc] initWithFrame:frame];
	theButton.layer.cornerRadius=4.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 1.0f;
    theButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [theButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];
    
    return theButton;
}

-(void)singIn:(id)sender
{	
}

-(void)signUp:(id)sender
{
	[_loginController didSelectSignUp];
}

-(void)login:(id)sender
{
    [sender resignFirstResponder];
}
/*
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
    [self dismissKeyboard];
    //    [((ShakeViewController*)_baseViewController) dismissDropDownMenuWithSelection:nil];
}
*/
-(void)dismissKeyboard
{
    [self endEditing:YES];
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

/*
#pragma mark -
#pragma mark ScrollView Delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	if (!_horizontalScrollingNeeded) {
		NSLog(@"%@",@"scrollViewDidScroll");
		[scrollView setContentOffset: CGPointMake(_horizontalValue, scrollView.contentOffset.y)];		
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	_horizontalScrollingNeeded = NO;
}
*/

#pragma mark -
#pragma mark TextField Delegate methods

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_nameField.textColor == [UIColor lightGrayColor]) {
        _nameField.text = @"";
        _nameField.textColor = [UIColor blackColor];
    }
	
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}


@end
