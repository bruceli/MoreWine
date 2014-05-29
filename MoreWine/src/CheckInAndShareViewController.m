//
//  CheckInAndShareViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import <ShareSDK/ShareSDK.h>

#import "CheckInAndShareViewController.h"
#import "MaImageFilterViewController.h"
#import "MaTabBarController.h"
#import "MaScaleImageView.h"

#import "AppDelegate.h"

#import "FXBlurView.h"
#import "MaUtility.h"

#define TOOL_BAR_VIEW_HEIGHT 60
#define STAT_BAR_WITH_NAV_BAR_HEIGHT 64

@interface CheckInAndShareViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MaImageFitlerProcessDelegate,MaScaleImageViewDelegate>

@end

@implementation CheckInAndShareViewController
@synthesize blurView = _blurView;

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
    

    NSString* theImageName;
	if ([MaUtility hasFourInchDisplay])
		theImageName = @"backgroundImage_586h.png";
	else
		theImageName = @"backgroundImage.png";
    
	UIImage* image = [UIImage imageNamed:theImageName];
	UIImageView* _bkgBlurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	_bkgBlurImageView.image = image;
    [self.view addSubview:_bkgBlurImageView];
    
	_baseView = [[UIView alloc] initWithFrame:self.view.bounds];
	_baseView.backgroundColor = [UIColor clearColor];
	
	[self setupBlurView];
	[self setupNavBarItems];
	[self setupTextView];
    [self setupToolbarView];
	
	[self.view addSubview:_baseView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_infoTextView becomeFirstResponder];
}

//http://cases.azoft.com/ios7-like-dynamic-blur-effect-using-fxblurview/
- (void)showOnViewController:(UIViewController *)vc {  
    _parentVC = vc;  
    [_parentVC addChildViewController:self];  
	
    _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];  
    _blurView.underlyingView = vc.view;  
    _blurView.tintColor = [UIColor clearColor];  
    _blurView.updateInterval = 1;  
    _blurView.blurRadius = 10.f;  
    _blurView.alpha = 0.f;  
    _blurView.frame = vc.view.bounds;  
	
    [_parentVC.view addSubview:_blurView];  
    [_parentVC.view addSubview:self.view];  
	
    self.view.backgroundColor = [UIColor clearColor];  
    self.view.alpha = 0.f;  
    self.view.frame = vc.view.bounds;  
	
    [UIView animateWithDuration:0.1 animations:^{  
        _blurView.alpha = 1.f;  
    } completion:^(BOOL finished) {  
        [UIView animateWithDuration:0.1 animations:^{  
            self.view.alpha = 1.0f;  
        }];  
    }];  
}  


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupBlurView
{
    _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];  
    _blurView.underlyingView = _parentVC.view;  
    _blurView.tintColor = [UIColor clearColor];  
    _blurView.updateInterval = 1;  
    _blurView.blurRadius = 10.f;  
    _blurView.alpha = 0.f;  
    _blurView.frame = _parentVC.view.bounds;  
	[self.view addSubview:_blurView];
}

-(void)setupTextView
{
//	self.view.backgroundColor = [MaUtility getRandomColor];
    CGFloat textViewHeight = [self estimateTextViewHeight];
    _infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, STAT_BAR_WITH_NAV_BAR_HEIGHT, self.view.bounds.size.width, textViewHeight)];
    _infoTextView.backgroundColor = [UIColor darkGrayColor];
//    _infoTextView.contentInset = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f ,5.0f);
    _infoTextView.font = [UIFont systemFontOfSize:18.0f];
    _infoTextView.textColor = [UIColor whiteColor];
    _infoTextView.textAlignment = NSTextAlignmentLeft;
    _infoTextView.alwaysBounceVertical = NO;
    _infoTextView.alwaysBounceHorizontal = NO;
    _infoTextView.showsHorizontalScrollIndicator = NO;
    
//    _infoTextView.contentSize = CGSizeMake(_infoTextView.frame.size.width - _infoTextView.contentInset.left - _infoTextView.contentInset.right, _infoTextView.frame.size.height - _infoTextView.contentInset.top - _infoTextView.contentInset.bottom);
	//    [self.view addSubview:_infoTextView];
	[_baseView addSubview:_infoTextView];
}


-(void)setupImageView
{
}


-(void)setupNavBarItems
{
    // back button
    UIImage *backImage = [UIImage imageNamed:@"navigation_Back_Icon"];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, backImage.size.width, backImage.size.height)];
	button.backgroundColor = [MaUtility getRandomColor];
	[button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:backImage forState:UIControlStateNormal];

    // share button
    //    UIImage *shareImage = [UIImage imageNamed:@"navigation_Back_Icon"];
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, backImage.size.width, backImage.size.height)];
	shareButton.backgroundColor = [MaUtility getRandomColor];
	[shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
	[shareButton setBackgroundImage:backImage forState:UIControlStateNormal];

	//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *negativeSpacerLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *negativeSpacerMid = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	negativeSpacerLeft.width = -16;// it was -6 in iOS 6
	[self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacerLeft, [[UIBarButtonItem alloc] initWithCustomView:button],negativeSpacerMid,[[UIBarButtonItem alloc] initWithCustomView:shareButton], nil] animated:NO];
    
}

-(void)setupToolbarView
{
    CGFloat textHeight = [self estimateTextViewHeight];
    _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, STAT_BAR_WITH_NAV_BAR_HEIGHT+textHeight, self.view.bounds.size.width, TOOL_BAR_VIEW_HEIGHT)];
    UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
	topLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[_toolBarView addSubview:topLineView];
    
    UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, TOOL_BAR_VIEW_HEIGHT, self.view.bounds.size.width, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[_toolBarView addSubview:bottomLineView];
    
    UIImageView* shareIconView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 23, 14, 14)];
    shareIconView.backgroundColor = [MaUtility getRandomColor];
    [_toolBarView addSubview:shareIconView];
    
    UILabel* shareToLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 23, 47, 14)];
    shareToLabel.font = [UIFont systemFontOfSize:14.0f];
    shareToLabel.textColor = [UIColor whiteColor];
    shareToLabel.backgroundColor = [UIColor clearColor];
    shareToLabel.text = @"分享到:";
    [_toolBarView addSubview:shareToLabel];
    
    _weChatButton = [[UIButton alloc] initWithFrame:CGRectMake(109, 8, 44, 44)];
	_weChatButton.backgroundColor = [UIColor clearColor];
    [_weChatButton addTarget:self action:@selector(weChatShare) forControlEvents:UIControlEventTouchUpInside];
	[_weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
	[_toolBarView addSubview:_weChatButton];
    
    _weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(161, 8, 44, 44)];
	_weiboButton.backgroundColor = [UIColor clearColor];
    [_weiboButton addTarget:self action:@selector(weiboShare) forControlEvents:UIControlEventTouchUpInside];
	[_weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
	[_toolBarView addSubview:_weiboButton];
    
    isWeChatShareSelected = NO;
    isWeiboShareSelected = NO;

    CGRect frame = CGRectMake(self.view.bounds.size.width-44-17, 8, 44, 44);
    _shareImageButton = [[UIButton alloc] initWithFrame:frame];
    _shareImageButton.backgroundColor = [UIColor clearColor];
    _shareImageButton.layer.cornerRadius=0.0f;
    _shareImageButton.layer.masksToBounds=YES;
    _shareImageButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    _shareImageButton.layer.borderWidth= 0.7f;
    [_shareImageButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [[_shareImageButton imageView] setContentMode: UIViewContentModeScaleAspectFit];

    
    
    [_toolBarView addSubview:_shareImageButton];

    [_baseView addSubview:_toolBarView];
}

-(CGFloat)estimateTextViewHeight
{
    CGFloat keyboardHeight = 216.0f;
    CGFloat textViewHeight = self.view.bounds.size.height - keyboardHeight - TOOL_BAR_VIEW_HEIGHT - STAT_BAR_WITH_NAV_BAR_HEIGHT ;
    return textViewHeight;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    // Get Keyboard Top point
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat textViewHeight = self.view.bounds.size.height - keyboardHeight -_toolBarView.bounds.size.height - _infoTextView.frame.origin.y ;
    CGRect destTextRect = CGRectMake(_infoTextView.frame.origin.x, _infoTextView.frame.origin.y, _infoTextView.frame.size.width, textViewHeight);
    
    CGFloat toolbarY = self.view.bounds.size.height - keyboardHeight -_toolBarView.bounds.size.height ;
    CGRect toolbarRect = CGRectMake(self.view.bounds.origin.x, toolbarY, _toolBarView.frame.size.width, _toolBarView.frame.size.height);
    
    [UIView animateWithDuration:0.4f delay:0.0f options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _infoTextView.frame = destTextRect;
                         _infoTextView.contentSize = CGSizeMake(_infoTextView.frame.size.width - _infoTextView.contentInset.left - _infoTextView.contentInset.right, _infoTextView.frame.size.height - _infoTextView.contentInset.top - _infoTextView.contentInset.bottom);
                         _toolBarView.frame = toolbarRect;
//                         NSLog(@"contentsize %@",NSStringFromCGSize(_infoTextView.contentSize));

                     }
                     completion:^(BOOL finished){}];
}

-(void)cancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)attachImage:(UIImage*)image
{
    _image = image;
    [_shareImageButton setImage:_image forState:UIControlStateNormal];
}


#pragma mark -
#pragma mark ActionSheet

-(void)showActionSheet
{
    [_infoTextView resignFirstResponder];

    //    UIActionSheet *withImageActionSheet;
//    UIActionSheet *nilImageActionSheet;
    UIActionSheet *theSheet;
    if (_image == nil) // take image from cam or lib;
    {
        theSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄", @"从相册中选择", nil];
        _nilImageActionSheet = theSheet;
    }
    else    // view or remove image
    {
        theSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:@"删除" otherButtonTitles:@"查看", nil];
        _withImageActionSheet = theSheet;
    }
    
	theSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[theSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%d, index",buttonIndex);
    
    if (actionSheet == _nilImageActionSheet) {
        if (buttonIndex == 0)
        {
            [self.navigationController setNavigationBarHidden: YES animated:YES];
            [self presentCam];
        }
        else if (buttonIndex == 1)
        {
            [self.navigationController setNavigationBarHidden: YES animated:YES];
            [self presentLibrary];
        }
        else if (buttonIndex == 2)
        {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [_infoTextView becomeFirstResponder];
        }
    }
    else
    {
        if (buttonIndex == 0)
        {
            [self deleteImage];
        }
        else if (buttonIndex == 1)
        {
            [self viewImage];
            [_infoTextView resignFirstResponder];
        }
        else if (buttonIndex == 2)
        {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [_infoTextView becomeFirstResponder];
        }

    }
}


-(void)presentCam
{
	_picker = [[UIImagePickerController alloc] init];
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		NSLog(@"%@",@"camView presentCam: cam Unavaliable, return!;");
		return;
	}
    
	NSLog(@"%@",@"camView presentCam");
	_picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	_picker.showsCameraControls = YES;
	_picker.allowsEditing = YES;
	_picker.delegate = self;
    [self presentViewController:_picker animated:YES completion:nil];
}

-(void)presentLibrary
{
	NSLog(@"%@",@"camView presentLibrary");
    
	_picker = [[UIImagePickerController alloc] init];
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		NSLog(@"%@",@"camView presentLib: cam Unavaliable, return!;");
		return;
	}
	_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	_picker.allowsEditing = YES;
	_picker.delegate = self;
    
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        image = info[UIImagePickerControllerEditedImage];
        //        _imageView.image = image;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _imgFilterController = [[MaImageFilterViewController alloc] init];
    _imgFilterController.currentImage = image;
    _imgFilterController.delegate = self;
    
    CGRect destFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect origFrame = CGRectMake(0, self.view.frame.size.height*2, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_imgFilterController.view];
    _imgFilterController.view.frame = origFrame;
    
    [self addChildViewController:_imgFilterController];
    [_imgFilterController didMoveToParentViewController:self];
    //    _imgFilterController.hidesBottomBarWhenPushed = YES;
    AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [UIView animateWithDuration:0.4f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imgFilterController.view.frame = destFrame;
                         app.tabBarController.tabBar.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         [[UIApplication sharedApplication] setStatusBarHidden:YES];
                     }];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    [self.navigationController setNavigationBarHidden: NO animated:YES];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigationController setNavigationBarHidden: NO animated:YES];
    }];

}

#pragma mark -
#pragma mark MaImageFilterDelegate

- (void)imageFitlerProcessDone:(UIImage *)image
{
    _image = image;
    [_shareImageButton setImage:image forState:UIControlStateNormal];
    [self.navigationController setNavigationBarHidden: NO animated:YES];

}

- (void)dismissImageFilter;
{
    CGRect destFrame = CGRectMake(0, self.view.frame.size.height*2, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView animateWithDuration:0.4f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imgFilterController.view.frame = destFrame;
                     }
                     completion:^(BOOL finished){
                         [_imgFilterController.view removeFromSuperview];
                         [_imgFilterController removeFromParentViewController];
                         [[UIApplication sharedApplication] setStatusBarHidden:NO];
                         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
                         
                         //UIStatusBarStyleLightContent
                         AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                         app.tabBarController.tabBar.hidden = NO;
                         [self.navigationController setNavigationBarHidden: NO animated:YES];
                     }];
    
}

#pragma mark - View Image
#pragma mark

-(void) deleteImage
{
    [UIView animateWithDuration:0.4 animations:^{[_shareImageButton setImage:nil forState:UIControlStateNormal];}];
    _image = nil;
}



-(void)viewImage
{
	[self toggleZoom:_toolBarView];
}

-(void)toggleZoom:(UIView*) sender
{
	if (_hiddenView)
	{
		// zoomout
		CGRect frame = [sender.window convertRect:_hiddenView.frame fromView:_hiddenView.superview];
		[UIView animateWithDuration:0.3 animations:
		 ^{ sender.frame = frame; sender.alpha = 0.0;[_infoTextView becomeFirstResponder];}
						 completion:
		 ^(BOOL finished){
			 [_scaleImageView removeFromSuperview];
			 _hiddenView = nil;
			 _scaleImageView = nil;
             
		 }];
	}
	else
	{					// zoom in
		_hiddenView = (UIView*)sender;
		CGRect frame = [sender.window convertRect:sender.frame fromView:sender.superview];
		
		CGRect screenRect = [[UIScreen mainScreen] bounds];
		_scaleImageView = [[MaScaleImageView alloc] initWithFrame:frame];
		_scaleImageView.scaleImageViewDelegate = self;
		[UIView animateWithDuration:0.3 animations:^{ _scaleImageView.frame = screenRect; }];
		
		[_scaleImageView setImage:_image ];
		[sender.window addSubview:_scaleImageView];
	}
}


#pragma mark -
#pragma mark navigationController Delegate -- for Hide StatusBar

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}



#pragma mark -
#pragma mark ShareSDK

-(BOOL)checkShareAuthStatusWithType:(ShareType)type
{
    return [ShareSDK hasAuthorizedWithType:type];
}

-(void)weChatShare     // check if Auth then set selected flag
{
/*    if(![self checkShareAuthStatusWithType:ShareTypeWeixiTimeline]) // not selected, then check has Auth first.
    {   // do Auth first
        [ShareSDK authWithType:ShareTypeWeixiTimeline options:nil result:^(SSAuthState state, id<ICMErrorInfo> error)
         {
             if (state == SSAuthStateSuccess){
                 NSLog(@"成功");
             }
             else if (state == SSAuthStateFail){
                 NSLog(@"失败");
             }
         }];
    }
    */
    if (isWeChatShareSelected == YES) // weibo has selected,
    {
        isWeChatShareSelected = NO;
        [_weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
    }
    else
    {
        isWeChatShareSelected = YES;
        [_weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat_hilight"] forState:UIControlStateNormal];
    }
}

-(void)weiboShare
{
    if (![self checkShareAuthStatusWithType:ShareTypeSinaWeibo]) {
        {   // do Auth first
            [ShareSDK authWithType:ShareTypeSinaWeibo options:nil result:^(SSAuthState state, id<ICMErrorInfo> error)
             {
                 if (state == SSAuthStateSuccess){
                     NSLog(@"成功");
                 }
                 else if (state == SSAuthStateFail){
                     NSLog(@"失败");
                 }
             }];
        }
    }
    
    if (isWeiboShareSelected) // weibo has selected,
    {
        isWeiboShareSelected = NO;
        [_weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
    }
    else
    {
        isWeiboShareSelected = YES;
        [_weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo_hilight"] forState:UIControlStateNormal];
    }
}

-(void)share
{
    id<ISSContent> publishContent = [ShareSDK content:_infoTextView.text
                                       defaultContent:@""
                                                image:[ShareSDK jpegImageWithImage:_image quality:0.7f]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];

    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:INHERIT_VALUE
                                            title:@"TEST"
                                              url:@"http://www.google.com.hk"
                                       thumbImage:[ShareSDK jpegImageWithImage:_image quality:0.3f]
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    weiboDone = NO;
    weChatDone = NO;
    __block BOOL weiboStatus = NO;
    __block BOOL weChatStatus = NO;
    dispatch_group_t group = dispatch_group_create();
    if (isWeChatShareSelected)
        dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // block1
        NSLog(@"ShareTypeWeixiTimeline");
        [ShareSDK shareContent:publishContent
                          type:ShareTypeWeixiTimeline
                   authOptions:nil
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            weChatDone = YES;

                            if (state == SSPublishContentStateSuccess)
                            {
                                weChatStatus =YES;
                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            }
                            else if (state == SSPublishContentStateFail)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                            }
                        }];
        NSLog(@"ShareTypeWeixiTimeline End");
    });
    else
        weChatDone = YES;
    
    if (isWeiboShareSelected)
        dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        // block2
        NSLog(@"ShareTypeSinaWeibo");
        [ShareSDK shareContent:publishContent
                          type:ShareTypeSinaWeibo
                   authOptions:nil
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            weiboDone = YES;

                            if (state == SSPublishContentStateSuccess)
                            {
                                weiboStatus = YES;
                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            }
                            else if (state == SSPublishContentStateFail)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                            }
                        }];
        NSLog(@"ShareTypeSinaWeibo End");
    });
    else
        weiboDone = YES;
    
    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^ {
        
        while(true)
        {
            if (weiboDone && weChatDone)
                break;
        }
        
        if (!(weiboStatus && weChatStatus)) { // failed

        if (!weiboStatus) {
                NSLog(@"%@",@"weibo Failed");
            }
            else
            {   // success, disable it
                isWeiboShareSelected = NO;
                [_weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
            }
            
            if (!weChatStatus) {
                NSLog(@"%@",@"wechat Failed");
            }
            else
            {
                isWeChatShareSelected = NO;
                [_weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
            }
        }
       else // Success.
           [self cancel];
        NSLog(@"Block3");
    });
    

    
    /*
    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_group_t group = dispatch_group_create();
    if (isWeChatShareSelected)
        dispatch_sync(queue, ^{[ShareSDK shareContent:publishContent
                                                          type:ShareTypeWeixiTimeline
                                                   authOptions:nil
                                                 statusBarTips:YES
                                                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                            if (state == SSPublishContentStateSuccess)
                                                            {
                                                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                weChatStatus = YES;
                                                            }
                                                            else if (state == SSPublishContentStateFail)
                                                            {
                                                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                            }
                                                        }];}
                         );
    else
        weChatStatus = YES;
    
    if (isWeiboShareSelected)
        dispatch_sync(queue, ^{[ShareSDK shareContent:publishContent
                                                          type:ShareTypeSinaWeibo
                                                   authOptions:nil
                                                 statusBarTips:YES
                                                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                            if (state == SSPublishContentStateSuccess)
                                                            {
                                                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                weiboStatus = YES;
                                                            }
                                                            else if (state == SSPublishContentStateFail)
                                                            {
                                                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                            }
                                                        }];}
                         );
    else
        weiboStatus = YES;

    
    
//    dispatch_group_notify(group, queue, ^{
        if (!(weiboStatus && weChatStatus)) { // failed
            if (!weiboStatus) {
                NSLog(@"%@",@"weibo Failed");
            }
            else
            {   // success, disable it
                isWeiboShareSelected = NO;
                [_weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
            }
            
            if (!weChatStatus) {
                NSLog(@"%@",@"wechat Failed");
            }
            else
            {
                isWeChatShareSelected = NO;
                [_weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
            }
        }
        else // Success.
            [self cancel];

//    }
//);
 */
}


-(void)workingThread
{
    
}

-(BOOL)shareWeChat:(id)content
{
    __block BOOL status = NO;

    [ShareSDK shareContent:content
                      type:ShareTypeWeixiTimeline
               authOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            status = YES;
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                        }
                    }];
    return status;
}

-(BOOL)shareWeibo:(id)content
{
    __block BOOL status = NO;

    [ShareSDK shareContent:content
                      type:ShareTypeSinaWeibo
               authOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            status = YES;
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                        }
                    }];
    return status;
}


@end
