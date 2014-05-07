//
//  MaImageFilterViewController.h
//  MoreWine
//
//  Created by Thunder on 14-5-6.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MaImageFitlerProcessDelegate;

@interface MaImageFilterViewController : UIViewController
{
    UIImageView* _imageView;
    UIScrollView* _scrollerView;
    UIImage* _currentImage;
//  BOOL shouldHideStatusBar;
}
@property(nonatomic,assign) id<MaImageFitlerProcessDelegate> delegate;
@property(nonatomic,retain)UIImage *currentImage;
@end

@protocol MaImageFitlerProcessDelegate <NSObject>
- (void)dismissImageFilter;
- (void)imageFitlerProcessDone:(UIImage *)image;
@end

