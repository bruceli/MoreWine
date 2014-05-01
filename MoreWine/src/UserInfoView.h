//
//  UserInfoView.h
//  MoreWine
//
//  Created by Thunder on 4/10/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@interface UserInfoView : UIScrollView
{
	LoginViewController* _loginController;

    UIImageView* _headerView;
    UILabel* _nameLabel;
    UIButton* _checkInStatusButton;
    UIButton* _favoritStatusButton;
	UIButton* _tagButton;

}

@property (nonatomic, retain) LoginViewController *loginController;

@end
