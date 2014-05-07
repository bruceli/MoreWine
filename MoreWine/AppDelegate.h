//
//  AppDelegate.h
//  MoreWine
//
//  Created by Bruce Li on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaDataSettingManager,UserInfoManager,MaTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MaTabBarController *_tabBarController;
	UIImageView* _bkgBlurImageView;
    UserInfoManager* _userInfoMgr;
	MaDataSettingManager* _dataSettingMgr;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MaDataSettingManager *dataSettingMgr;
@property (nonatomic, retain) UserInfoManager *userInfoMgr;
@property (nonatomic, retain) MaTabBarController *tabBarController;

@end
