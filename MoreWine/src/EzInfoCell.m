//
//  EzInfoCell.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "EzInfoCell.h"
#import "StyleIndicatorView.h"


@implementation EzInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        topLineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topLineView];

        [self setupCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCell
{
    [self initHeaderImageView];
    [self initNameLable];
    [self initStyleIndicator];
    [self initDistanceLable];
}

-(void)initHeaderImageView
{
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 53, 53)];
    _headerImageView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    
    CALayer *imageLayer = _headerImageView.layer;
    [imageLayer setCornerRadius:25];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    [self addSubview:_headerImageView];
	
}

-(void)initNameLable
{
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(88, 23, 90, 14)];
    _nameLable.backgroundColor = [UIColor clearColor];
    _nameLable.font = [UIFont systemFontOfSize:14.0f];
    _nameLable.text = @"MORE WINE";
    _nameLable.textColor = [UIColor whiteColor];
    [self addSubview:_nameLable];
}

-(void)initStyleIndicator
{
//    -(StyleIndicatorView*)initStyleIndicatorViewWithFrame:(CGRect)inFrame ByDict:(NSDictionary*)dict
    CGRect frame = CGRectMake(190, 24, 95, 13);
    _indicatorView = [[StyleIndicatorView alloc] initStyleIndicatorViewWithFrame:frame ByDict:nil];
    
    [self addSubview:_indicatorView];
}

-(void)initDistanceLable
{
    _distanceLable = [[UILabel alloc] initWithFrame:CGRectMake(275, 23, 44, 14)];
    _distanceLable.backgroundColor = [UIColor clearColor];
    _distanceLable.font = [UIFont systemFontOfSize:8.0f];
    _distanceLable.text = @"11024.0Km";
    _distanceLable.textAlignment = NSTextAlignmentRight;
    _distanceLable.textColor = [UIColor whiteColor];
    [self addSubview:_distanceLable];
}

- (void)setCellInfo:(NSDictionary*)dict
{
	[self setImageTemp];
}

-(void) setImageTemp
{
	int r = arc4random() % 4;
	NSString *noString = [NSString stringWithFormat:@"%d",r];
	NSMutableString* imageNameString = [NSMutableString stringWithString:noString];
	[imageNameString appendString:@"headerImage.png"];
//	NSLog(@"%@",imageNameString);
	UIImage* img = [UIImage imageNamed:imageNameString];
	_headerImageView.image = img;
}

@end
