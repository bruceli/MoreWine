//
//  SGFocusImageItem.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem
@synthesize title =  _title;
@synthesize imageURL =  _imageURL;
@synthesize tag =  _tag;
@synthesize targetURL = _targetURL;
- (void)dealloc
{
    [_title release];
    [_imageURL release];
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title image:(NSString *)imageURL tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageURL = imageURL;
        self.tag = tag;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title image:(NSString *)imageURL targetURL:(NSString*)targetURL tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageURL = imageURL;
        self.tag = tag;
        self.targetURL = targetURL;
    }
    
    return self;
}


@end
