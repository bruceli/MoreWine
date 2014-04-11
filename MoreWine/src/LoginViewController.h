//
//  LoginViewController.h
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInView,SignUpView,UserInfoView;

@interface LoginViewController : UIViewController
{
	SignInView* _signInView;
	SignUpView* _signUpView;
	UserInfoView* _userInfoView;
}
-(void)didSelectSignUp;
-(void)signUpCancel;
-(void)signIn;
-(void)signUp;

@end
