//
//  InfoCell.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//


// Sharp Mask refrence:
// http://stackoverflow.com/questions/14670985/adding-a-circle-mask-layer-on-an-uiimageview



#import <UIKit/UIKit.h>
@class StyleIndicatorView, NameInfoView, DetailView;

@interface InfoCell : UITableViewCell
{
    UIImageView* _headerImageView;
    UILabel* _nameLable;
    StyleIndicatorView* _indicatorView;
    UILabel* _distanceLable;
    NameInfoView* _nameInfoView;
//    DetailView* _detailView;
    UITextView* _detailTextView;
    NSDictionary* _infoDict;
}
- (void)setCellInfo:(NSDictionary*)dict;

@end
