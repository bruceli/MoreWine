//
//  TagManagerViewController.h
//  MoreWine
//
//  Created by Thunder on 4/29/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagManagerViewController : UIViewController
{
    UIScrollView* _scrollView;
    UIView* _addTagView;
    NSMutableArray* _tagButtonArray;
    UIButton* _addTagButton;

    
    BOOL _editMode;
}
@end
