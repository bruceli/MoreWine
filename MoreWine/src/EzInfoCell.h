//
//  EzInfoCell.h
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StyleIndicatorView;

@interface EzInfoCell : UITableViewCell
{
    UIImageView* _headerImageView;
    UILabel* _nameLabel;
    StyleIndicatorView* _indicatorView;
    UILabel* _distanceLabel;
    
    NSDictionary* _infoDict;
}
- (void)setCellInfo:(NSDictionary*)dict;

@end
