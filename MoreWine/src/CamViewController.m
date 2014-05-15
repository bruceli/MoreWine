//
//  CamViewController.m
//  MoreWine
//
//  Created by Thunder on 4/18/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAsset.h>

#import "MaImageFilterViewController.h"
#import "MaTabBarController.h"
#import "CamViewController.h"
#import "AppDelegate.h"
#import "MaUtility.h"
#import "MaRoundButton.h"

@interface CamViewController () <UIActionSheetDelegate,MaImageFitlerProcessDelegate>

@end

@implementation CamViewController

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
	NSLog(@"%@",@"camView ViewDidLoad");
//	[self updateLastPhotoThumbnail];
//    shouldHideStatusBar = NO;
//    [self hideStatusBar];

	_hasMedia = NO;
//	_firstRun = YES;
//	_camTakePictButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 320, 320)];
//    [_camTakePictButton setImage:[UIImage imageNamed:@"cam_center.png"] forState:UIControlStateNormal];
//	[_camTakePictButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    //    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄", @"从相册中选择", nil];

    CGFloat y = 340;
    MaRoundButton* camButton = [[MaRoundButton alloc] initWithFrame:CGRectMake(17, y, 138, 40) title:@"拍摄"];
    [self.view addSubview:camButton];
    [camButton addTarget:self action:@selector(presentCam) forControlEvents:UIControlEventTouchUpInside];

    MaRoundButton* libButton = [[MaRoundButton alloc] initWithFrame:CGRectMake(165, y, 138, 40) title:@"从相册中选择"];
    [libButton addTarget:self action:@selector(presentLibrary) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:libButton];

	[self.view addSubview:_camTakePictButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setALAssetsLibraryNotification];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentCam
{
//	[self setupOverlayView];

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
//	_picker.cameraOverlayView = _overlayView;
//    [self hideStatusBar];
    [self presentViewController:_picker animated:YES completion:nil];
}
/*
-(void)hideStatusBar
{
    AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarController updateStatusBar];
}
*/
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
//    [self hideStatusBar];

    [self presentViewController:_picker animated:YES completion:nil];
}

-(void)takePictureButtonPressed:(id)sender
{
	
}

-(void)setupOverlayView
{
    _newMedia = YES;
	_overlayView = [[UIView alloc] initWithFrame:self.view.frame];
	_overlayView.backgroundColor = [UIColor clearColor];

    CGFloat toolbarY, toolbarHeight;
    CGRect camButtonFrame, libButtonFrame, closeButtonFrame, toolbarFrame, scaleAreaFrame;
    UIView* bottonToolbar = [[UIView alloc]initWithFrame:CGRectZero];

    if ([MaUtility hasFourInchDisplay])
    {
        toolbarY = 426;
        toolbarHeight = self.view.frame.size.height - toolbarY;
    
        CGFloat theScaleY = (self.view.frame.size.height - toolbarHeight - 320)/2;
        scaleAreaFrame = CGRectMake(0, theScaleY, self.view.frame.size.width,self.view.frame.size.width);

        camButtonFrame = CGRectMake((self.view.frame.size.width - 80)/2, (toolbarHeight - 80)/2, 80, 80);
        closeButtonFrame = CGRectMake(260, (toolbarHeight - 40)/2, 40, 40);
        libButtonFrame = CGRectMake(20, (toolbarHeight - 40)/2, 40, 40);
        toolbarFrame = CGRectMake(0, toolbarY, self.view.frame.size.width, toolbarHeight) ;
        bottonToolbar.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        toolbarY = 380;
        toolbarHeight = 100;
        CGFloat theScaleY = (self.view.frame.size.height - toolbarHeight - 320)/2;
        scaleAreaFrame = CGRectMake(0, theScaleY, self.view.frame.size.width,self.view.frame.size.width);

        camButtonFrame = CGRectMake((self.view.frame.size.width - 80)/2, (toolbarHeight - 80)/2, 80, 80);
        closeButtonFrame = CGRectMake(260, (toolbarHeight - 40)/2, 40, 40);
        libButtonFrame = CGRectMake(20, (toolbarHeight - 40)/2, 40, 40);
        toolbarFrame =  CGRectMake(0, toolbarY, self.view.frame.size.width, toolbarHeight);
        bottonToolbar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    }

    // toolbar
    bottonToolbar.frame = toolbarFrame;

    UIView* scaleRectView = [[UIView alloc] initWithFrame:scaleAreaFrame];
    scaleRectView.backgroundColor = [UIColor clearColor];
    scaleRectView.layer.cornerRadius= 0.0f;
    scaleRectView.layer.masksToBounds=YES;
    scaleRectView.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    scaleRectView.layer.borderWidth= 1.0f;

    [_overlayView addSubview:scaleRectView];
    
	// cap button
	UIButton* capButton = [[UIButton alloc] initWithFrame:camButtonFrame];
    [capButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [capButton setImage:[UIImage imageNamed:@"cam_captureButton"] forState:UIControlStateNormal];
	[bottonToolbar addSubview:capButton];

    UIButton* closebutton = [[UIButton alloc] initWithFrame:closeButtonFrame];
	[closebutton addTarget:self action:@selector(dismissCam:) forControlEvents:UIControlEventTouchUpInside];
    closebutton.backgroundColor = [MaUtility getRandomColor];
	[bottonToolbar addSubview:closebutton];

	// select from library
	UIButton* chooseLibraryButton = [[UIButton alloc] initWithFrame:libButtonFrame];
	chooseLibraryButton.backgroundColor = [MaUtility getRandomColor];
	[chooseLibraryButton addTarget:self action:@selector(dismissCamAndShowLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [chooseLibraryButton setImage:_camRollLastImage forState:UIControlStateNormal];
	[bottonToolbar addSubview:chooseLibraryButton];
	
	[_overlayView addSubview:bottonToolbar];
}

-(void)takePicture:(id)sender
{
    [_picker takePicture];
}

-(void)dismissCam:(id)sender
{
//	NSLog(@"%@",@"camView dismissCam;");
	[_picker dismissViewControllerAnimated:YES completion:^{_hasMedia = YES;}];
}


-(void)dismissCamAndShowLibrary:(id)sender
{
    _newMedia = NO;

//	NSLog(@"%@",@"camView dismissCamAndShowLibrary;");
	[_picker dismissViewControllerAnimated:YES completion:^{_hasMedia = YES; [self presentLibrary];}];
}

-(UIImage *)imageWithImage:(UIImage *)image CovertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
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
    app.tabBarController.tabBar.hidden = YES;

    [UIView animateWithDuration:0.4f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imgFilterController.view.frame = destFrame;
                     }
                     completion:^(BOOL finished){
                         [[UIApplication sharedApplication] setStatusBarHidden:YES];
                     }];
/*
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _imageView.image = image;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
 */
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
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateLastPhotoThumbnail
{
    ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];

    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSInteger numberOfAssets = [group numberOfAssets];
        if (numberOfAssets > 0) {
            NSInteger lastIndex = numberOfAssets - 1;
            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:lastIndex] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                UIImage *thumbnail = [UIImage imageWithCGImage:[result thumbnail]];
                if (thumbnail && thumbnail.size.width > 0) {
                    _camRollLastImage = thumbnail;
                    *stop = YES;
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

-(void)setALAssetsLibraryNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLastPhotoThumbnail) name:ALAssetsLibraryChangedNotification object:nil];
}


-(void)showActionSheet
{
//    shouldHideStatusBar = YES;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];

//    [self setNeedsStatusBarAppearanceUpdate];

    /*if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
     [self presentCam];
     else
     [self presentLibrary];
     */
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄", @"从相册中选择", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%d, index",buttonIndex);
	if (buttonIndex == 0)
    {
        [self presentCam];
	}
    else if (buttonIndex == 1)
    {
        [self presentLibrary];
    }
    else if (buttonIndex == 2)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}


- (void)imageFitlerProcessDone:(UIImage *)image
{

}

- (void)dismissImageFilter;
{
    CGRect destFrame = CGRectMake(0, self.view.frame.size.height*2, self.view.frame.size.width, self.view.frame.size.height);

    [UIView animateWithDuration:0.2f delay:0.0f
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

                     }];
}


/*
-(BOOL)prefersStatusBarHidden
{
    return shouldHideStatusBar;
}
*/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


@end
