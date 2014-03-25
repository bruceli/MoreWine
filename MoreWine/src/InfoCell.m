//
//  InfoCell.m
//  MoreWine
//
//  Created by Thunder on 2/25/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "InfoCell.h"
#import <QuartzCore/QuartzCore.h>
#import "StyleIndicatorView.h"
#import "MaUtility.h"

//===================================
#pragma mark - InfoCell Elements == NameInfoView
@interface NameInfoView : UIView
{
    UILabel* _nameLabel;
    UILabel* _name;
    UILabel* _discriptionLabel;
}
-(void)setNameLabel:(NSString*)string;
-(void)setDiscriptionLabel:(NSString*)string;

@end

@implementation NameInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 1)];
        topLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
        [self addSubview:topLineView];
        
        UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, 220, 1)];
        bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
        [self addSubview:bottomLineView];
    }
    return self;
}

-(void)setNameLabel:(NSString*)string
{
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 35, self.frame.size.height-6)];
    _name.font = [UIFont systemFontOfSize:8.0f];
    _name.text = NSLocalizedString(@"MA_MoreWine_Cell_Recommend", nil);
	_name.textColor = [UIColor whiteColor];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 84, self.frame.size.height)];
    _nameLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameLabel.text = string;
	_nameLabel.textColor = [UIColor whiteColor];

    [self addSubview:_name];
    [self addSubview:_nameLabel];
}

-(void)setDiscriptionLabel:(NSString*)string
{
    _discriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 5, self.frame.size.width - 128, self.frame.size.height - 6 )];
    _discriptionLabel.font = [UIFont systemFontOfSize:8.0f];
    _discriptionLabel.text = string;
    _discriptionLabel.textAlignment = NSTextAlignmentRight;
	_discriptionLabel.textColor = [UIColor whiteColor];
    [self addSubview:_discriptionLabel];
}

@end
//===================================
/*
//===================================
#pragma mark - InfoCell Elements == DetailView
@interface DetailView : UIView
{
    UITextView* _discriptionTextView;
}
@end

@implementation DetailView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
@end
//===================================
*/


#pragma mark - InfoCell
@implementation InfoCell

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

- (void)setCellInfo:(NSDictionary*)dict
{
    _infoDict = dict;
    [self setImageTemp];

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
    [self initNameInfoView];
    [self initDetailInfoView];
}

-(void)initHeaderImageView
{
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 29, 53, 53)];
    _headerImageView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    
    CALayer *imageLayer = _headerImageView.layer;
    [imageLayer setCornerRadius:26];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    [self addSubview:_headerImageView];
}

-(void)initNameLabel
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 20, 90, 14)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameLabel.text = @"MORE WINE";
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
}

-(void)initStyleIndicator
{
    //    -(StyleIndicatorView*)initStyleIndicatorViewWithFrame:(CGRect)inFrame ByDict:(NSDictionary*)dict
    CGRect frame = CGRectMake(190, 21, 70, 14);
    _indicatorView = [[StyleIndicatorView alloc] initStyleIndicatorViewWithFrame:frame ByDict:nil];
//    _indicatorView.backgroundColor = [MaUtility getRandomColor];
    [self addSubview:_indicatorView];
}

-(void)initDistanceLabel
{
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(262, 23, 44, 14)];
    _distanceLabel.backgroundColor = [UIColor clearColor];
    _distanceLabel.font = [UIFont systemFontOfSize:8.0f];
    _distanceLabel.text = @"11024.0Km";
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_distanceLabel];
}


-(void)initNameInfoView
{
    _nameInfoView = [[NameInfoView alloc]initWithFrame:CGRectMake(88, 45, 225, 22)];
    _nameInfoView.backgroundColor = [UIColor clearColor];
    [_nameInfoView setNameLabel:@"喵星喵星喵星"];
    [_nameInfoView setDiscriptionLabel:@"类地行星，高度文明"];

    [self addSubview:_nameInfoView];
}

-(void)initDetailInfoView
{
    _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 69, 223, 35)];
//    _detailTextLabel.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    _detailTextLabel.backgroundColor = [UIColor clearColor];
    _detailTextLabel.font = [UIFont systemFontOfSize:8.0f];
    _detailTextLabel.text = @"宇宙中的一颗类地行星，上面有高度的文明，生活着拥有极高智慧的喵星人。";
	_detailTextLabel.numberOfLines = 0;
	_detailTextLabel.textColor = [UIColor whiteColor];
    [self addSubview:_detailTextLabel];
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
