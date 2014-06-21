//
//  CheckInAndShareViewController.h
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXBlurView,MaImageFilterViewController,MaScaleImageView;

@interface CheckInAndShareViewController : UIViewController
{
    UITextView* _infoTextView;
    UIView* _baseView;
	UIViewController* _parentVC;
	UIView* _toolBarView;
	FXBlurView* _blurView;
    
    UIButton *_shareImageButton;
    UIImage *_image;
    
    UIButton *_weChatButton;
    UIButton *_weiboButton;
    UIActionSheet *_withImageActionSheet;
    UIActionSheet *_nilImageActionSheet;
    
    UIImagePickerController *_picker;
    MaImageFilterViewController *_imgFilterController;
    
    UIView *_hiddenView;
    MaScaleImageView* _scaleImageView;
    
    BOOL isWeChatShareSelected;
    BOOL isWeiboShareSelected;
    
    __block BOOL weChatDone;
    __block BOOL weiboDone;
}
@property (nonatomic, retain) FXBlurView *blurView;
- (void)showOnViewController:(UIViewController *)vc;
- (void)attachImage:(UIImage*)image;
@end
