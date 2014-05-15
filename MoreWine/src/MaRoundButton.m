//
//  MaRoundButton.m
//  MoreWine
//
//  Created by Thunder on 14-5-13.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import "MaRoundButton.h"

@implementation MaRoundButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)titleString
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:titleString forState:UIControlStateNormal];
		[self setupButton];
    }
    return self;
}


-(void)setupButton
{
	self.layer.cornerRadius=9.0f;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    self.layer.borderWidth= 0.7f;
	self.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    //	[self buttonWidthWithTitle:_titleString];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    printf("MyButton touchesBegan\n");
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    self.layer.borderWidth= 2.0f;
    
    [super touchesBegan:touches withEvent:event];
    //    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    printf("MyButton touchesEnded\n");
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    self.layer.borderWidth= 0.7f;
    
    [super touchesEnded:touches withEvent:event];
    //    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    printf("MyButton touchesCancelled\n");
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    self.layer.borderWidth= 0.7f;
    
    [super touchesCancelled:touches withEvent:event];
    //  [self.nextResponder touchesCancelled:touches withEvent:event];
    
}

@end
