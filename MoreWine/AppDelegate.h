//
//  AppDelegate.h
//  MoreWine
//
//  Created by Bruce Li on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaDataSettingManager;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UITabBarController *_tabBarController;
	UIImageView* _bkgBlurImageView;

	MaDataSettingManager* _dataSettingMgr;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MaDataSettingManager *dataSettingMgr;

@end
