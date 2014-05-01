//
//  TagListViewController.h
//  MoreWine
//
//  Created by Thunder on 4/29/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagListViewController : UIViewController
{
	NSString* _tagString;

}
- (id)initWithTag:(NSString*)tagString;
@end
