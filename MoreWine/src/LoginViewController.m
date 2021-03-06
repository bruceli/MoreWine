//
//  LoginViewController.m
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "LoginViewController.h"
#import "SignInView.h"
#import "SignUpView.h"
#import "UserInfoView.h"
#import "AppDelegate.h"
#import "UserInfoManager.h"
#import "CheckInDetailViewController.h"
#import "FavoriteViewController.h"
#import "TagManagerViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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
    AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUserInfoView];

    if (![app.userInfoMgr isLogIn]) {
        [self needSignIn];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSignInView
{
    CGRect frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
	_signInView = [[SignInView alloc] initWithFrame:frame];
	_signInView.loginController = self;
	
	[self.view addSubview:_signInView];
}

-(void)setupUserInfoView
{
    CGRect frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
	_userInfoView = [[UserInfoView alloc] initWithFrame:frame];
	_userInfoView.loginController = self;
	
	[self.view addSubview:_userInfoView];
}

-(void)didSelectSignUp
{
	NSLog(@"%@",@"didSelectSignUp");
	// create signUp view;
	CGRect frame = CGRectMake(320, 0, 320, self.view.frame.size.height);
	_signUpView = [[SignUpView alloc] initWithFrame:frame];	
    _signUpView.loginController = self;
	[self.view addSubview:_signUpView];
	
	// switch to signUp view
	CGRect loginDestFrame, signUpDestFrame;
	loginDestFrame = CGRectMake(-320, 0, 320, self.view.frame.size.height);
	signUpDestFrame = CGRectMake(0, 0, 320, self.view.frame.size.height);
	
	[UIView animateWithDuration:0.2f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
						 _signInView.frame = loginDestFrame;
						 _signUpView.frame = signUpDestFrame;
                     }
                     completion:^(BOOL finished){
                         _signInView = nil;
                     }];
}

-(void)signUp
{

}

-(void)signIn
{

}

-(void)signUpCancel
{
    CGRect signInDestFrame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    CGRect signUpDestFrame = CGRectMake (320, 0, 320, self.view.frame.size.height);
	_signInView = [[SignInView alloc] initWithFrame:CGRectMake(-320, 0, 320, self.view.frame.size.height)];
	_signInView.loginController = self;
    [self.view addSubview:_signInView];
    
    [UIView animateWithDuration:0.2f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
						 _signInView.frame = signInDestFrame;
						 _signUpView.frame = signUpDestFrame;
                     }
                     completion:^(BOOL finished){
                         _signUpView = nil;
                     }];
}

-(void)needSignIn
{
    // need login ,show  signinView Here
    CGRect signInDestFrame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    CGRect signInOrigFrame = CGRectMake(0, self.view.frame.size.height, 320, self.view.frame.size.height);

    CGRect userInfoDestFrame = CGRectMake(0, -self.view.frame.size.height, 320, self.view.frame.size.height);

	_signInView = [[SignInView alloc] initWithFrame:signInOrigFrame];
	_signInView.loginController = self;
	
	[self.view addSubview:_signInView];
    
    [UIView animateWithDuration:0.2f delay:0.4f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
						 _signInView.frame = signInDestFrame;
                         _userInfoView.frame = userInfoDestFrame;
                     }
                     completion:^(BOOL finished){
                         _signUpView = nil;
                     }];    
}

-(void)didSignIn
{

}


-(void)pushCheckInDetailController
{
    CheckInDetailViewController* viewController = [[CheckInDetailViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];

}

-(void)pushFavoriteDetailController
{
    FavoriteViewController* viewController = [[FavoriteViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
}

-(void)pushTagDetailController
{
	TagManagerViewController* viewController = [[TagManagerViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
}

@end
