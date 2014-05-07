//
//  CamViewController.h
//  MoreWine
//
//  Created by Thunder on 4/18/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaImageFilterViewController;

@interface CamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIButton* _camTakePictButton;
	UIImageView* _imageView;
	UIView* _overlayView;
    UIButton* _camRollButton;
    UIImage* _camRollLastImage;
    
	BOOL _newMedia;
//	BOOL _firstRun;
	BOOL _hasMedia;
//    BOOL shouldHideStatusBar;
	UIImagePickerController* _picker;
    MaImageFilterViewController* _imgFilterController;
}

@end
