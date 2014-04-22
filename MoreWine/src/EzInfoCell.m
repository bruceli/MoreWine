//
//  EzInfoCell.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "EzInfoCell.h"
#import "StyleIndicatorView.h"
#import "MaUtility.h"


@implementation EzInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        topLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.1];
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
    [self initNameLabel];
    [self initStyleIndicator];
    [self initDistanceLabel];
}

-(void)initHeaderImageView
{
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 53, 53)];
//    _headerImageView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    
    CALayer *imageLayer = _headerImageView.layer;
    [imageLayer setCornerRadius:25];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    [self addSubview:_headerImageView];
	
}

-(void)initNameLabel
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 28, 90, 14)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameLabel.text = @"MORE WINE";
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
}

-(void)initStyleIndicator
{
//    -(StyleIndicatorView*)initStyleIndicatorViewWithFrame:(CGRect)inFrame ByDict:(NSDictionary*)dict
    CGRect frame = CGRectMake(190, 29, 70, 14);
    _indicatorView = [[StyleIndicatorView alloc] initStyleIndicatorViewWithFrame:frame ByDict:nil];
//    _indicatorView.backgroundColor = [MaUtility getRandomColor];
    [self addSubview:_indicatorView];
}

-(void)initDistanceLabel
{
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(265, 28, 44, 14)];
    _distanceLabel.backgroundColor = [UIColor clearColor];
    _distanceLabel.font = [UIFont systemFontOfSize:8.0f];
    _distanceLabel.text = @"11024.0Km";
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_distanceLabel];
}

- (void)setCellInfo:(NSDictionary*)dict
{
	[self setImageTemp];
	if (dict != nil) {
		_nameLabel.text = @"searchResult";
	}
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
