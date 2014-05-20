//
//  MaScaleImageView.h
//  MoreArt
//
//  Created by Thunder on 11/30/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MaScaleImageViewDelegate
-(void)toggleZoom:()view;
@end 

@interface MaScaleImageView : UIScrollView <UIScrollViewDelegate>
{
	UIImageView* _imageView;
	CGRect _imageViewFrame;
	float _minZoomRate;
	float _maxZoomRate;
	
	BOOL _isImageReady;
}

//-(void)loadImageFrom:(NSString*)imgPath;
-(void)setPreloadedImages:(UIImage*)img;
-(void)changeRotation;
-(void)setImage:(UIImage*)img;

@property (nonatomic, weak) id <MaScaleImageViewDelegate> scaleImageViewDelegate; 


@end
