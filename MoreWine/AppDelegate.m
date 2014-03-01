//
//  AppDelegate.m
//  MoreWine
//
//  Created by Bruce Li on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ListViewController.h"
#import "MaNavigationBar.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  
//    _tabBarController = (UITabBarController *)self.window.rootViewController;
    _tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];

    //    UINavigationController* webNavController = [[UINavigationController alloc] initWithRootViewController:webViewController];

    // init mainView
    MainViewController* mainView = [[MainViewController alloc] init];
    // init Custom NavBar for MainView
    UINavigationController *mainNavController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
    UIColor *firstColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [[MaNavigationBar appearance] setBarTintGradientColors:colors];
    [[mainNavController navigationBar] setTranslucent:NO];
    [mainNavController setViewControllers:@[mainView]];
    
    
    // init Recommend view
    ListViewController* recomView = [[ListViewController alloc] init];
    UINavigationController *recomNavController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
    [[MaNavigationBar appearance] setBarTintGradientColors:colors];
    [[recomNavController navigationBar] setTranslucent:NO];
    [recomNavController setViewControllers:@[recomView]];
    
    // init Search View
    ListViewController* searchView = [[ListViewController alloc] init];
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithNavigationBarClass:[MaNavigationBar class] toolbarClass:nil];
    [[MaNavigationBar appearance] setBarTintGradientColors:colors];
    [[searchNavController navigationBar] setTranslucent:NO];
    [searchNavController setViewControllers:@[searchView]];

/*   // init tabBar items
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"activity_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"activity.png"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"agenda_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"agenda.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"settings_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"settings.png"]];
*/
    

    [viewControllers addObject:mainNavController]; // MainView with custom Nav
    [viewControllers addObject:recomNavController];
    [viewControllers addObject:searchNavController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    _tabBarController.viewControllers = viewControllers;
    self.window.rootViewController = _tabBarController;

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

@end
