//
//  LoginView.h
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;

@interface SignInView : UIScrollView <UITextFieldDelegate>
{
	UITextField* _nameField;
	UITextField* _pswField;
	UITextField* _newUserNameField;

	LoginViewController* _loginController;
}

@property (nonatomic, retain) LoginViewController *loginController;

@end
