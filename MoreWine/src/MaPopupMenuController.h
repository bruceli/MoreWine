//
//  MaPopupMenuController.h
//  haitao
//
//  Created by Thunder on 4/22/13.
//  Copyright (c) 2013 magicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaSaleViewController;

@interface MaPopupMenuController : UITableViewController
{
    NSMutableArray* _dataSourceArray;
    NSString* _selectedType;
    
    NSMutableDictionary* _paramDict;
}
@property(nonatomic, assign) MaSaleViewController *delegate;
@property(nonatomic, retain) NSMutableArray *dataSourceArray;
@property(nonatomic, retain) NSString *selectedType;

@end
