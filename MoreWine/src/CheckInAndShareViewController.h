//
//  CheckInAndShareViewController.h
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXBlurView;

@interface CheckInAndShareViewController : UIViewController
{
    UITextView* _infoTextView;
    UIView* _baseView;
	UIViewController* _parentVC;
	
	FXBlurView* _blurView;
}
@property (nonatomic, retain) FXBlurView *blurView;
- (void)showOnViewController:(UIViewController *)vc;
@end
