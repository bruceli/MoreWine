//
//  StyleIndicatorView.m
//  MoreWine
//
//  Created by Thunder on 3/1/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "StyleIndicatorView.h"

@implementation StyleIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(StyleIndicatorView*)initStyleIndicatorViewWithFrame:(CGRect)inFrame ByDict:(NSDictionary*)dict
{
    self = [super initWithFrame:inFrame];
    if (!self)
        return nil;

    CGRect frame = CGRectMake(0, 0, 13, 13);
    UIImageView* imgView1 = [[UIImageView alloc] initWithFrame:frame];
    imgView1.backgroundColor = [UIColor clearColor];
	imgView1.image = [UIImage imageNamed:@"barType_coffee.png"];
    [self addSubview:imgView1];
    
    frame = CGRectMake(frame.origin.x+17, frame.origin.y, 13, 13);
    UIImageView* imgView2 = [[UIImageView alloc] initWithFrame:frame];
    imgView2.backgroundColor = [UIColor clearColor];
	imgView2.image = [UIImage imageNamed:@"barType_headphones.png"];
    [self addSubview:imgView2];

    frame = CGRectMake(frame.origin.x+17, frame.origin.y, 13, 13);
    UIImageView* imgView3 = [[UIImageView alloc] initWithFrame:frame];
    imgView3.backgroundColor = [UIColor clearColor];
	imgView3.image = [UIImage imageNamed:@"barType_music.png"];
    [self addSubview:imgView3];

    frame = CGRectMake(frame.origin.x+17, frame.origin.y, 13, 13);
    UIImageView* imgView4 = [[UIImageView alloc] initWithFrame:frame];
    imgView4.backgroundColor = [UIColor clearColor];
    [self addSubview:imgView4];

    frame = CGRectMake(frame.origin.x+17, frame.origin.y, 13, 13);
    UIImageView* imgView5 = [[UIImageView alloc] initWithFrame:frame];
    imgView5.backgroundColor = [UIColor clearColor];
    [self addSubview:imgView5];

    
    
    /*
    // define dict key1:YES
    //             key2:NO
    //             key3:NO
    
    if ([[dict objectForKey:@"key1"] isEqualToString:@"YES"]) {
        // add element;
    }
    
    if ([[dict objectForKey:@"key1"] isEqualToString:@"YES"]) {
        // add element;
    }

    if ([[dict objectForKey:@"key1"] isEqualToString:@"YES"]) {
        // add element
    }

   */
    
    return self;
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
