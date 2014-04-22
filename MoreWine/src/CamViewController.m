//
//  CamViewController.m
//  MoreWine
//
//  Created by Thunder on 4/18/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>

#import "CamViewController.h"
#import "MaUtility.h"

@interface CamViewController ()

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
	
	_hasMedia = NO;
	_firstRun = YES;
	_camTakePictButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 70, 170, 170)];
	_camTakePictButton.backgroundColor = [MaUtility getRandomColor];
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
	label.text = @"take pict";
	[label sizeToFit];
	[_camTakePictButton addSubview:label];
	[_camTakePictButton addTarget:self action:@selector(presentCam) forControlEvents:UIControlEventTouchUpInside];

	[self.view addSubview:_camTakePictButton];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
	NSLog(@"%@",@"camView viewDidAppear");
	
	if (_firstRun) {
		_firstRun = NO;
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
			[self presentCam];
		else
			[self presentLibrary];
	}		
}

-(void)presentCam
{
	[self setupOverlayView];

	_picker = [[UIImagePickerController alloc] init];
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		NSLog(@"%@",@"camView presentCam: cam Unavaliable, return!;");
		return;	
	}

	NSLog(@"%@",@"camView presentCam");
	_picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	_picker.showsCameraControls = NO;
	_picker.allowsEditing = YES;
	_picker.delegate = self;
	_picker.cameraOverlayView = _overlayView;
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
	_picker.allowsEditing = NO;
	_picker.delegate = self;
    [self presentViewController:_picker animated:YES completion:nil];
}

-(void)takePictureButtonPressed:(id)sender
{
	
}

-(void)setupOverlayView
{
	_overlayView = [[UIView alloc] initWithFrame:self.view.frame];
	_overlayView.backgroundColor = [UIColor clearColor];
// UIBar	
	UIView* topToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
	topToolBar.backgroundColor = [MaUtility getRandomColor];
	
	UIView* bottonToolbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 97, self.view.frame.size.width, 97)];
	bottonToolbar.backgroundColor = [MaUtility getRandomColor];
	
	// close button
	UIButton* closebutton = [[UIButton alloc] initWithFrame:CGRectMake(17, 0, 40, 44)];
	closebutton.backgroundColor = [MaUtility getRandomColor];
	[closebutton addTarget:self action:@selector(dismissCam:) forControlEvents:UIControlEventTouchUpInside];
	[topToolBar addSubview:closebutton];

	// cap button
	UIButton* capButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 0, 80, 97)];	
	capButton.backgroundColor = [MaUtility getRandomColor];
	[bottonToolbar addSubview:capButton];

	// select from library
	UIButton* chooseLibraryButton = [[UIButton alloc] initWithFrame:CGRectMake(17, 0, 40, 40)];
	chooseLibraryButton.backgroundColor = [MaUtility getRandomColor];
	[chooseLibraryButton addTarget:self action:@selector(dismissCamAndShowLibrary:) forControlEvents:UIControlEventTouchUpInside];
	[bottonToolbar addSubview:chooseLibraryButton];
	
//	[bottonToolbar addTarget:self action:@selector(takePictureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[_overlayView addSubview:topToolBar];
	[_overlayView addSubview:bottonToolbar];
}

-(void)dismissCam:(id)sender
{
	NSLog(@"%@",@"camView dismissCam;");
	[_picker dismissViewControllerAnimated:YES completion:^{_hasMedia = YES;}];
}


-(void)dismissCamAndShowLibrary:(id)sender
{
	NSLog(@"%@",@"camView dismissCamAndShowLibrary;");
	[_picker dismissViewControllerAnimated:YES completion:^{_hasMedia = YES; [self presentLibrary];}];
}

- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}

- (void) useCameraRoll:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _imageView.image = image;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
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

@end