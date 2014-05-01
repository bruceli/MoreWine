//
//  MaDropDownMenuController.h
//  MoreWine
//
//  Created by Thunder on 4/3/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXBlurView;

typedef NS_ENUM(NSInteger, MA_DropDownMenuAlignment) {
    MA_DropDownMenuAlignment_Left,
    MA_DropDownMenuAlignment_Self
};


@interface MaDropDownMenuController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UIView* _touchView;
    UITableView* _tableView;
	FXBlurView* _blurView;
    NSArray* _dataSourceArray;
    UIViewController* _baseViewController;
    CGFloat _menuWidth;
    MA_DropDownMenuAlignment _aligment;
}
@property (nonatomic) CGFloat menuWidth;
@property (nonatomic) MA_DropDownMenuAlignment aligment;

//_popover = [[FPPopoverController alloc] initWithViewController:controller];
-(id)initWithViewController:(UIViewController*)viewController;
-(void)presentPopoverFromPoint:(CGPoint)point;
@end
