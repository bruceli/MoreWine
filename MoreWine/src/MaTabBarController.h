//
//  MaTabBarController.h
//  MoreWine
//
//  Created by Thunder on 14-5-7.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaTabBarController : UITabBarController
@property (nonatomic) BOOL isStatusBarHidden;
-(void)updateStatusBar;
@end
