//
//  MaImageFilterViewController.m
//  MoreWine
//
//  Created by Thunder on 14-5-6.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//
#import <GPUImage/GPUImage.h>

#import "MaImageFilterViewController.h"
#import "MaUtility.h"
#import "IFLomofiFilter.h"

@interface MaImageFilterViewController () <UIGestureRecognizerDelegate>

@end

@implementation MaImageFilterViewController
@synthesize currentImage = _currentImage;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self prefersStatusBarHidden];
//    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];

//    self.view.backgroundColor = [MaUtility getRandomColor];
//    self.hidesBottomBarWhenPushed = YES;
    
    CGFloat topButtonY;
    if ([MaUtility hasFourInchDisplay]) {
        topButtonY = 20;
    }
    else{
        topButtonY = 10;
    }
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(20, topButtonY, 40, 40)];
    [leftBtn setBackgroundColor:[UIColor redColor]];
    [leftBtn addTarget:self action:@selector(cancleFilter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"camera_btn_ok.png"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(260, topButtonY, 40, 40)];
    [rightBtn setBackgroundColor:[UIColor greenColor]];
    [rightBtn addTarget:self action:@selector(fitlerDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.388 alpha:1.000]];
    
    _imageView = [[UIImageView alloc ] initWithFrame:CGRectZero];
    [self.view addSubview:_imageView];

    CGRect scrollFrame, imgViewFrame;
    if ([MaUtility hasFourInchDisplay]) {
        imgViewFrame = CGRectMake(0, 80, 320, 320);
        scrollFrame = CGRectMake(0, imgViewFrame.origin.y +imgViewFrame.size.height + 20, 320, 140);
    }
    else
    {
        imgViewFrame = CGRectMake(0, 60, 320, 320);
        scrollFrame = CGRectMake(0, imgViewFrame.origin.y +imgViewFrame.size.height, 320, 110);
    }
    
    _imageView.frame = imgViewFrame;
    [_imageView setBackgroundColor:[UIColor darkGrayColor]];
    _imageView.image = _currentImage;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;

    NSArray *array = [NSArray arrayWithObjects:@"原图",@"EFF1",@"EFF2",@"EFF3",@"EFF4",nil];
    _scrollerView = [[UIScrollView alloc]initWithFrame:scrollFrame];
    _scrollerView.backgroundColor = [MaUtility getRandomColor];
    _scrollerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.alwaysBounceHorizontal = YES;
    _scrollerView.bounces = YES;
    
    float x, effImageSize, effGap,effLabelY,effLabelWidth;
    if ([MaUtility hasFourInchDisplay]) {
        effImageSize = 85.0f;
        effGap = 10.0f;
        effLabelY = 10 + effImageSize + 8;
        effLabelWidth = effImageSize ;
    }
    else
    {
        effImageSize = 55.0f;
        effGap = 7.0f;
        effLabelY = 10 + effImageSize + 4;
        effLabelWidth = effImageSize ;
    }
    
    for(int i=0;i<[array count];i++)
    {
        x = 10 + (effImageSize + effGap)*i;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageStyle:)];
        recognizer.numberOfTouchesRequired = 1;
        recognizer.numberOfTapsRequired = 1;
        recognizer.delegate = self;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, effLabelY, effLabelWidth, 23)];
        [label setBackgroundColor:[MaUtility getRandomColor]];
        [label setText:[array objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label setTag:i];
        [label addGestureRecognizer:recognizer];
        
        [_scrollerView addSubview:label];
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 10, effImageSize, effImageSize)];
        [bgImageView setTag:i];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;

        bgImageView.backgroundColor = [MaUtility getRandomColor];
        [bgImageView addGestureRecognizer:recognizer];
        [bgImageView setUserInteractionEnabled:YES];
        UIImage *bgImage = [self changeImage:i imageView:nil];
        bgImageView.image = bgImage;
        [_scrollerView addSubview:bgImageView];
        NSLog(@"%@ thumbnail frame", NSStringFromCGRect(bgImageView.frame));
    }
    _scrollerView.contentSize = CGSizeMake(x + effImageSize , 80);
    NSLog(@"%@ thumbnail frame", NSStringFromCGSize(_scrollerView.contentSize));

    [self.view addSubview:_scrollerView];
    
	// Do any additional setup after loading the view.
}

- (void)setImageStyle:(UITapGestureRecognizer *)sender
{
    UIImage *image =   [self changeImage:sender.view.tag imageView:nil];
    [_imageView setImage:image];
}

-(UIImage*) processImage:(UIImage*)image
{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    
    // Linear downsampling
    GPUImageBrightnessFilter *passthroughFilter = [[GPUImageBrightnessFilter alloc] init];
    passthroughFilter.brightness = 0.5;
//    [passthroughFilter forceProcessingAtSize:CGSizeMake(640.0, 480.0)];
    [stillImageSource addTarget:passthroughFilter];
    [passthroughFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage *nearestNeighborImage = [passthroughFilter imageFromCurrentFramebuffer];
    return nearestNeighborImage;
}

-(UIImage*)IFFilterWithImage:(UIImage*)image
{
//    IFLomofiFilter* passthroughFilter = [[IFLomofiFilter alloc] init];
    
    GPUImageFilterGroup* passthroughFilter = [[GPUImageAmatorkaFilter alloc] init];
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];

    [stillImageSource addTarget:passthroughFilter];
    [passthroughFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage* nearestNeighborImage = [passthroughFilter imageFromCurrentFramebuffer];
    
    return nearestNeighborImage;
}

-(UIImage*)otherFilterWithImage:(UIImage*)image
{
    
    GPUImageFilterGroup* passthroughFilter = [[GPUImageMissEtikateFilter alloc] init];
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    
    [stillImageSource addTarget:passthroughFilter];
    [passthroughFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage* nearestNeighborImage = [passthroughFilter imageFromCurrentFramebuffer];
    
    return nearestNeighborImage;
}

-(UIImage*)reallyNeedThisEffect:(UIImage*)image
{
    
    GPUImageFilterGroup* passthroughFilter = [[GPUImageSoftEleganceFilter alloc] init];
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    
    [stillImageSource addTarget:passthroughFilter];
    [passthroughFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage* nearestNeighborImage = [passthroughFilter imageFromCurrentFramebuffer];
    
    return nearestNeighborImage;
}



-(UIImage *)changeImage:(int)index imageView:(UIImageView *)imageView
{
    UIImage *image;
    switch (index) {
        case 0:
        {
            return _currentImage;
        }
            break;
        case 1:
        {
            image = [self processImage:_currentImage];
        }
            break;
        case 2:
        {
            image = [self IFFilterWithImage:_currentImage];
            break;
        }
            break;
        case 3:
        {
            image = [self otherFilterWithImage:_currentImage];
        }
            break;
        case 4:
        {
            image = [self reallyNeedThisEffect:_currentImage];
        }
            break;

    }
    return image;
}

- (void)cancleFilter:(id)sender
{
    [_delegate dismissImageFilter];

}

- (void)fitlerDone:(id)sender
{
    [_delegate imageFitlerProcessDone:_imageView.image];
    [_delegate dismissImageFilter];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
