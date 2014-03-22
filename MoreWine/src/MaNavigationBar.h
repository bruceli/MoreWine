//
//  MaNavigationBar.h
//  MoreWine
//
//  Created by Thunder on 2/27/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

// custom NavBar
//http://www.appcoda.com/customize-navigation-status-bar-ios-7/
//http://stackoverflow.com/questions/14747665/how-to-create-custom-navigation-bar-like-bestbuy-app
//https://github.com/chroman/CRGradientNavigationBar


#import <UIKit/UIKit.h>
@class BTBlurredView;
@interface MaNavigationBar : UINavigationBar
{
	BTBlurredView* _blurView;
}
- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors;
@end
