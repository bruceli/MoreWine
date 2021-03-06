//
//  MaTagButton.h
//  MoreWine
//
//  Created by Thunder on 3/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MA_TagButtonStatus) {
    MA_TagButtonStatus_None,
    MA_TagButtonStatus_EditMode_Normal,
    MA_TagButtonStatus_EditMode_Marked
};

#define MA_TagButton_editMode_Gap 0.0f

@interface MaTagButton : UIButton
{
	NSString* _titleString;
	BOOL _addTagButton;
    MA_TagButtonStatus _tagStatus;
    UIView* _markView;
}
@property (nonatomic) BOOL addTagButton;
@property (nonatomic, readonly) MA_TagButtonStatus tagStatus;
@property (nonatomic, retain) NSString* titleString;

- (id)initWithFrame:(CGRect)frame title:(NSString*)titleString;
- (void)reverseTagStatus;
- (void)setEditMode;
- (void)sizeToFit;
@end

/*
@interface MaAddTagButton : MaTagButton
{
    
}
@end
*/