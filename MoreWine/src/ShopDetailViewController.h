//
//  ShopDetailViewController.h
//  MoreWine
//
//  Created by Thunder on 3/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
@class DetailNameView,MaTagButton;

@interface ShopDetailViewController : UIViewController <SGFocusImageFrameDelegate>
{
	UIImageView* _bkgBlurImageView;
	UIScrollView* _scrollView;
	SGFocusImageFrame* _hilightImageView;
	
	DetailNameView* _detailNameView;
	
	UILabel* _addressLabel;
	UILabel* _telLabel;
	UIView* _addTagView;
	UIView* _tagView;
	UIButton* _shakeButton;
	UIButton* _checkInButton;
	UIButton* _favoriteInButton;
    MaTagButton* _editTagButton;
    
    NSMutableArray* _tagButtonArray;

}
@end
