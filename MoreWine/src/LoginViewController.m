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
    CGRect frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
	_signInView = [[SignInView alloc] initWithFrame:frame];
	_signInView.loginController = self;
	
	[self.view addSubview:_signInView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
