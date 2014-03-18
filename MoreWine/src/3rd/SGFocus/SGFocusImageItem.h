//
//  SGFocusImageItem.h
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, retain)  NSString     *title;
@property (nonatomic, retain)  NSString      *imageURL;
@property (nonatomic, assign)  NSInteger     tag;
@property (nonatomic, retain)  NSString      *targetURL;

- (id)initWithTitle:(NSString *)title image:(NSString *)imageURL tag:(NSInteger)tag;
- (id)initWithTitle:(NSString *)title image:(NSString *)imageURL targetURL:(NSString*)targetURL tag:(NSInteger)tag;

@end
