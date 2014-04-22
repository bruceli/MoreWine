//
//  CamViewController.h
//  MoreWine
//
//  Created by Thunder on 4/18/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIButton* _camTakePictButton;
	UIImageView* _imageView;
	UIView* _overlayView;
	BOOL _newMedia;
	BOOL _firstRun;
	BOOL _hasMedia;
	UIImagePickerController *_picker;
}

@end
