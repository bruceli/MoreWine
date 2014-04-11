//
//  MaDropDownMenuController.h
//  MoreWine
//
//  Created by Thunder on 4/3/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXBlurView;
@interface MaDropDownMenuController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UIView* _touchView;
    UITableView* _tableView;
	FXBlurView* _blurView;
    NSArray* _dataSourceArray;
    UIViewController* _baseViewController;
}
//_popover = [[FPPopoverController alloc] initWithViewController:controller];
-(id)initWithViewController:(UIViewController*)viewController;
-(void)presentPopoverFromPoint:(CGPoint)point;
@end
