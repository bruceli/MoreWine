//
//  MaTagButton.m
//  MoreWine
//
//  Created by Thunder on 3/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "MaTagButton.h"

@implementation MaTagButton
//@synthesize addTagButton = _addTagButton;
@synthesize titleString = _titleString;
@synthesize tagStatus = _tagStatus;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setupButton];
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)titleString;
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.showsTouchWhenHighlighted = YES;
		_addTagButton = NO;
		_titleString = titleString;
		[self setupButton];
		if ([titleString isEqualToString:@"MA_ADD_TAG_BUTTON"]) {
			_addTagButton = YES;
			[self setTitle:@"添加标签" forState:UIControlStateNormal];
		}
		else
			[self addTitle];

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


-(void)addTitle
{
	[self setTitle:_titleString forState:UIControlStateNormal];
}

-(void)setEditMode
{
    _tagStatus = MA_TagButtonStatus_EditMode_Normal;

  /*  if ([_titleString isEqualToString:@"MA_ADD_TAG_BUTTON"])
        return;
    CGRect finalFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width +MA_TagButton_editMode_Gap , self.frame.size.height);
    
    CGRect origFrame = CGRectMake(-22, 0, 22, 22);
    CGRect destFrame = CGRectMake(0, 0, 22, 22);
    _markView = [[UIView alloc] initWithFrame:origFrame];
    _markView.userInteractionEnabled = YES;
//    - (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;
    [self insertSubview:_markView belowSubview:[self.subviews lastObject]];
  //  [self addSubview:_markView];
    _tagStatus = MA_TagButtonStatus_EditMode_Normal;

    [UIView animateWithDuration:0.25f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _markView.frame = destFrame;
                         self.frame = finalFrame;
                         self.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
                         _markView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
                     }
                     completion:^(BOOL finished){
                         _markView.userInteractionEnabled =YES;
                         [self sendSubviewToBack:_markView];
                     }];
   */
}


-(void)setNormalMode
{
    if ([_titleString isEqualToString:@"MA_ADD_TAG_BUTTON"])
        return;
    
    CGRect origFrame = CGRectMake(-22, 0, 22, 22);
//    CGRect destFrame = CGRectMake(0, 0, 22, 22);
    if (_markView != nil) {
        
        [UIView animateWithDuration:0.25f delay:0.0f
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _markView.frame = origFrame;
                         }
                         completion:^(BOOL finished){
                             [_markView removeFromSuperview];
                             _markView = nil;

                         }];
    }
    _tagStatus = MA_TagButtonStatus_None;
}

- (void)reverseTagStatus
{
    switch (_tagStatus){
        case MA_TagButtonStatus_EditMode_Normal:
        {
            [UIView animateWithDuration:0.25f delay:0.0f
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:0.3];
                             }
                             completion:^(BOOL finished){
                             }];
            _tagStatus = MA_TagButtonStatus_EditMode_Marked;
        }
            break;
            
        case MA_TagButtonStatus_EditMode_Marked:
        {
            [UIView animateWithDuration:0.25f delay:0.0f
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.backgroundColor = [UIColor clearColor];
                             }
                             completion:^(BOOL finished){
                             }];
            _tagStatus = MA_TagButtonStatus_EditMode_Normal;
        }
            break;

        default:
            break;
    }
}

-(CGFloat)calculateWidth
{
	CGFloat width;
	if ([_titleString isEqualToString:@"MA_ADD_TAG_BUTTON"])
		width = 60;
	else
	{
		UILabel* theLabel = [[UILabel alloc] init];
		theLabel.font = [UIFont systemFontOfSize:10.0f];
		theLabel.text = _titleString;
		[theLabel sizeToFit];
		CGFloat gap = 30;
		//	NSLog(@"width is %f",theLabel.frame.size.width);
		width = theLabel.frame.size.width + gap;
        theLabel = nil;
	}
    
    if (width > 286)
        width = 286;
    
	return width;
}

-(void)sizeToFit
{
    CGFloat width = [self calculateWidth];
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    self.frame = frame;
}

@end
/*
@implementation MaAddTagButton


- (id)initWithFrame:(CGRect)frame
{
    CGRect theFrame = CGRectMake(frame.origin.x, frame.origin.y, 60.0f, frame.size.width);
    self = [super initWithFrame:theFrame];
    if (self) {
        [self setTitle:@"添加标签NEW" forState:UIControlStateNormal];
    }
    return self;
}

- (void)setAddButtonStatus:(MA_TagButtonStatus)status
{
    if (status == MA_TagButtonStatus_None) {
        [self setNormalAddButton];
    }
    else
    {
        [self setDimAddButton];
    }
}

-(void)setNormalAddButton
{
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.1]CGColor];
    self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
}

-(void)setDimAddButton
{
    self.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    self.titleLabel.textColor = [UIColor whiteColor];
}


@end
 */
