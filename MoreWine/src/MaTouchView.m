//
//  MaTouchView.m
//  MoreWine
//
//  Created by Thunder on 4/3/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MaTouchView.h"

@implementation MaTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@",@"hitTest Called");
    UIView *subview = [super hitTest:point withEvent:event];
    return subview;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
