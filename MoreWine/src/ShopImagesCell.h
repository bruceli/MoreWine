//
//  ShopImagesCell.h
//  MoreWine
//
//  Created by Bruce Li on 3/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"

@interface ShopImagesCell : UITableViewCell<SGFocusImageFrameDelegate>
{
    SGFocusImageFrame* _shopImageView;
}

@end
