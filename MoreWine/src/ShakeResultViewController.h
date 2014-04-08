//
//  ShakeResultViewController.h
//  MoreWine
//
//  Created by Thunder on 4/8/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeResultViewController : UIViewController
{
	UIScrollView* _scrollView;
	
	UIImageView* _resultImageView;
	UILabel* _resultNameLabel;
	UILabel* _materialDetailLabel;
	
	UIButton* _favButton;
	UIButton* _shareButton;
	UIButton* _oneMoreButton;
	
}
@end
