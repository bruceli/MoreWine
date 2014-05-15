//
//  MaTabBarController.m
//  MoreWine
//
//  Created by Thunder on 14-5-7.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import "MaTabBarController.h"
#import "AppDelegate.h"

@interface MaTabBarController ()

@end

@implementation MaTabBarController
@synthesize isStatusBarHidden;
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
    isStatusBarHidden = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return isStatusBarHidden;
}

-(void)updateStatusBar
{
    isStatusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
//    AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
