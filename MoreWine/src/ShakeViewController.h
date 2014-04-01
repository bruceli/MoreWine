//
//  ShakeViewController.h
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class ADDropDownMenuView;
@class FPPopoverController;
@protocol FPPopoverControllerDelegate,MaPopupMenuControllerDelegate;

@interface ShakeViewController : UIViewController <MaPopupMenuControllerDelegate>
{
	
    UIButton* _baseLiqButton;
    UIButton* _tastButton;
    UIButton* _tempButton;
    UIButton* _keyWordsButton;
    UIButton* _alcoholButton;
    UIButton* _typeButton;
    UIButton* _colorButton;
    UIButton* _whatEverButton;

	FPPopoverController *_popover;

}
@end
