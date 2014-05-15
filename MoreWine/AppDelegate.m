//
//  AppDelegate.m
//  MoreWine
//
//  Created by Bruce Li on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "AppDelegate.h"
#import "MaUtility.h"
#import <ShareSDK/ShareSDK.h>

#import "MainViewController.h"
#import "ListViewController.h"
#import "MaNavigationBar.h"
#import "StartViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "MaDataSettingManager.h"
#import "UserInfoManager.h"
#import "CamViewController.h"
#import "MaTabBarController.h"

@implementation AppDelegate
@synthesize dataSettingMgr = _dataSettingMgr;
@synthesize userInfoMgr = _userInfoMgr;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    // init Mgrs
    _dataSettingMgr = [[MaDataSettingManager alloc] init];
    _userInfoMgr = [[UserInfoManager alloc] init];
    
    _tabBarController = [[MaTabBarController alloc] init];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    [ShareSDK registerApp:@"22dc96bc434"];

    // init mainView
    // init Custom NavBar for MainView
   
//    UIColor* firstColor = [UIColor colorWithRed:64.0f/255.0f green:31.0f/255.0f blue:14.0f/255.0f alpha:1.0f];
//    UIColor* secondColor = [UIColor colorWithRed:38.0f/255.0f green:7.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
// NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];

    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:35/255.0 green:5/255.0 blue:5/255.0 alpha:0.4f]];

    MainViewController* mainView = [[MainViewController alloc] init];
    UINavigationController* mainNavController = [[UINavigationController alloc] initWithRootViewController:mainView];
//    mainNavController.navigationBar.translucent = NO; // If you have a navBar
    
    // init Recommend view
    ListViewController* recomView = [[ListViewController alloc] init];
    UINavigationController* recomNavController = [[UINavigationController alloc] initWithRootViewController:recomView];
    
    // init Search View
    SearchViewController* searchView = [[SearchViewController alloc] init];
    UINavigationController* searchNavController = [[UINavigationController alloc] initWithRootViewController:searchView];
	
//	StartViewController* startViewController = [[StartViewController alloc] init];
    
	LoginViewController* loginViewController = [[LoginViewController alloc] init];
    UINavigationController* loginNavController = [[UINavigationController alloc] initWithRootViewController:loginViewController];

    /*	UINavigationController *loginNavController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
    [[MaNavigationBar appearance] setBarTintGradientColors:colors];
    [[loginNavController navigationBar] setTranslucent:YES];
    [loginNavController setViewControllers:@[loginViewController]];	
*/
	UIViewController* camViewController = [[CamViewController alloc] init];   
 //   UINavigationController* camNavController = [[UINavigationController alloc] initWithRootViewController:camViewController];

    [viewControllers addObject:mainNavController]; // MainView with custom Nav
    [viewControllers addObject:recomNavController];
    [viewControllers addObject:camViewController];
	[viewControllers addObject:searchNavController];
	[viewControllers addObject:loginNavController];

	[self setupTabBarController:viewControllers];

	
	//blurImageView
	NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:theImageName]];
	
	self.window.rootViewController = _tabBarController;
	
//	self.window.rootViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


typedef NS_ENUM(NSInteger, MWTabBarType) {
    MWTabBar_Home = 0,
	MWTabBar_Recommend,    
	MWTabBar_Cam,
	MWTabBar_Search,
	MWTabBar_User
};                

-(void)setupTabBarController:(NSMutableArray*)controllerArray
{	
	//http://stackoverflow.com/questions/19662017/how-to-change-the-unselected-tabbaritem-color-in-ios7
	
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],NSForegroundColorAttributeName : [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]} forState:UIControlStateNormal];
	
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]} forState:UIControlStateSelected];

	
    _tabBarController.viewControllers = controllerArray;
	UITabBar *tabBar = _tabBarController.tabBar;
	tabBar.translucent = YES;
	tabBar.barStyle = UIBarStyleBlack;
		
	UITabBarItem *homeItem = [tabBar.items objectAtIndex:MWTabBar_Home];	
	UITabBarItem *recommendItem = [tabBar.items objectAtIndex:MWTabBar_Recommend];
	UITabBarItem *camItem = [tabBar.items objectAtIndex:MWTabBar_Cam];
	UITabBarItem *searchItem = [tabBar.items objectAtIndex:MWTabBar_Search];
	UITabBarItem *userItem = [tabBar.items objectAtIndex:MWTabBar_User];

	[homeItem setImage:[[UIImage imageNamed:@"barIcon_Home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[homeItem setSelectedImage:[[UIImage imageNamed:@"barIcon_HomeHiLight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	homeItem.title = NSLocalizedString(@"MA_MoreWine_TabBar_Home", nil);
	[homeItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -3.0f)];
	
	[recommendItem setImage:[[UIImage imageNamed:@"barIcon_Recommend.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[recommendItem setSelectedImage:[[UIImage imageNamed:@"barIcon_RecommendHiLight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	recommendItem.title = NSLocalizedString(@"MA_MoreWine_TabBar_Recommend", nil);
	[recommendItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -3.0f)];

	[camItem setImage:[[UIImage imageNamed:@"barIcon_Cam.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[camItem setSelectedImage:[[UIImage imageNamed:@"barIcon_CamHiLight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	camItem.title = NSLocalizedString(@"MA_MoreWine_TabBar_Cam", nil);
	[camItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -3.0f)];
	
	[searchItem setImage:[[UIImage imageNamed:@"barIcon_Search.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[searchItem setSelectedImage:[[UIImage imageNamed:@"barIcon_SearchHiLight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	searchItem.title = NSLocalizedString(@"MA_MoreWine_TabBar_Search", nil);
	[searchItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -3.0f)];

	[userItem setImage:[[UIImage imageNamed:@"barIcon_User.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[userItem setSelectedImage:[[UIImage imageNamed:@"barIcon_UserHiLight.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

	userItem.title = NSLocalizedString(@"MA_MoreWine_TabBar_User",nil);
	[userItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -3.0f)];
	
	// background image 
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBG.png"]];
    [tabBar insertSubview:imageView atIndex:1];
}

@end
