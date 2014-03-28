//
//  SignUpView.h
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;

@interface SignUpView : UIScrollView < UITextFieldDelegate >
{
	LoginViewController* _loginController;
	UITextField* _newUserNameField;
	UITextField* _firstPswField;
    UITextField* _secondPswField;
    UITextField* _emailField;
    UITextField* _verifyCodeField;
    
}

@property (nonatomic, retain) LoginViewController *loginController;
@end
