//
//  SignUpView.m
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "SignUpView.h"
#import "LoginViewController.h"
#import "MaUtility.h"

@implementation SignUpView
@synthesize loginController = _loginController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setupViews];
        self.alwaysBounceVertical = YES;
		CGSize scrollableSize = CGSizeMake(0, 555);
		[self setContentSize:scrollableSize];

    }
    return self;
}

-(void)setupViews
{
	self.backgroundColor = [MaUtility getRandomColor];
	
    CGRect frame = CGRectMake(17, 112, 286, 40);
    _newUserNameField = [self setupFieldByFrame:frame];
    [self addSubview:_newUserNameField];
    
    frame = CGRectMake(17, 157, 286, 40);
    _firstPswField = [self setupFieldByFrame:frame];
    [self addSubview:_firstPswField];
    
    frame = CGRectMake(17, 202, 286, 40);
    _secondPswField = [self setupFieldByFrame:frame];
    [self addSubview:_secondPswField];
    
    frame = CGRectMake(17, 247, 286, 40);
    _emailField = [self setupFieldByFrame:frame];
    [self addSubview:_emailField];
    
    frame = CGRectMake(17, 292, 286, 40);
    _verifyCodeField = [self setupFieldByFrame:frame];
    [self addSubview:_verifyCodeField];
    
    UIButton *singUpButton = [self setupButtonBy:CGRectMake(17, 342, 140, 40)];
    [singUpButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
	[singUpButton setTitle:NSLocalizedString(@"MA_MoreWine_LoginView_SignUp", nil) forState:UIControlStateNormal];
	[self addSubview:singUpButton];
    
    UIButton *singInButton = [self setupButtonBy:CGRectMake(163, 342, 140, 40)];
	[singInButton setTitle:NSLocalizedString(@"MA_MoreWine_LoginView_Cancel", nil) forState:UIControlStateNormal];
    [singInButton addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:singInButton];
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(139, 427, 42, 42)];
    imgView.image = [UIImage imageNamed:@"loginView_logo_icon"];
    [self addSubview:imgView];

}

-(UITextField*)setupFieldByFrame:(CGRect)frame
{
	UITextField* theField = [[UITextField alloc] initWithFrame:frame];
	theField.borderStyle = UITextBorderStyleNone;
	theField.backgroundColor = [UIColor clearColor];
    theField.layer.cornerRadius=4.0f;
    theField.layer.masksToBounds=YES;
    theField.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theField.layer.borderWidth= 1.0f;
	UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
	theField.leftView = paddingView;
	theField.leftViewMode = UITextFieldViewModeAlways;
	theField.delegate = self;
	theField.returnKeyType = UIReturnKeyDone;
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

-(void)signUp:(id)sender
{
    [_loginController signUp];
}

-(void)cancle:(id)sender
{
    [_loginController signUpCancel];
}

@end
