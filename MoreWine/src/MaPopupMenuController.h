//
//  MaPopupMenuController.h
//  haitao
//
//  Created by Thunder on 4/22/13.
//  Copyright (c) 2013 magicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MaPopupMenuControllerDelegate <NSObject>
@required
- (void) processCompleted;
@end

@interface MaPopupMenuController : UITableViewController
{

}

@property (nonatomic, assign)   id <MaPopupMenuControllerDelegate>   delegate;
@property(nonatomic, retain) NSMutableArray *dataSourceArray;
@property(nonatomic, retain) NSString *selectedType;

@end
