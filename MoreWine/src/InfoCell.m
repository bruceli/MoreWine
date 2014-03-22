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

//===================================
#pragma mark - InfoCell Elements == NameInfoView
@interface NameInfoView : UIView
{
    UILabel* _nameLable;
    UILabel* _name;
    UILabel* _discriptionLable;
}
-(void)setNameLable:(NSString*)string;
-(void)setDiscriptionLable:(NSString*)string;

@end

@implementation NameInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 210, 1)];
        topLineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topLineView];
        
        UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, 210, 1)];
        bottomLineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomLineView];
    }
    return self;
}

-(void)setNameLable:(NSString*)string
{
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 35, self.frame.size.height-6)];
    _name.font = [UIFont systemFontOfSize:8.0f];
    _name.text = @"推荐名人:";
	_name.textColor = [UIColor whiteColor];
    
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 84, self.frame.size.height)];
    _nameLable.font = [UIFont systemFontOfSize:14.0f];
    _nameLable.text = string;
	_nameLable.textColor = [UIColor whiteColor];

    [self addSubview:_name];
    [self addSubview:_nameLable];
}
-(void)setDiscriptionLable:(NSString*)string
{
    _discriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(122, 5, self.frame.size.width - 122, self.frame.size.height - 6 )];
    _discriptionLable.font = [UIFont systemFontOfSize:8.0f];
    _discriptionLable.text = string;
    _discriptionLable.textAlignment = NSTextAlignmentRight;
	_discriptionLable.textColor = [UIColor whiteColor];
    [self addSubview:_discriptionLable];
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
        topLineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topLineView];
        
        [self setupCell];
    }
    return self;
}

- (void)setCellInfo:(NSDictionary*)dict
{
    _infoDict = dict;
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

-(void)initNameLable
{
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(88, 20, 90, 14)];
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


-(void)initNameInfoView
{
    _nameInfoView = [[NameInfoView alloc]initWithFrame:CGRectMake(88, 45, 225, 22)];
    _nameInfoView.backgroundColor = [UIColor clearColor];
    [_nameInfoView setNameLable:@"喵星喵星喵星"];
    [_nameInfoView setDiscriptionLable:@"类地行星，高度文明"];

    [self addSubview:_nameInfoView];

}

-(void)initDetailInfoView
{
    _detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(83, 69, 235, 35)];
//    _detailTextView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
    _detailTextView.backgroundColor = [UIColor clearColor];
    _detailTextView.font = [UIFont systemFontOfSize:8.0f];
    _detailTextView.text = @"宇宙中的一颗类地行星，上面有高度的文明，生活着拥有极高智慧的喵星人。";
    _detailTextView.scrollEnabled = NO;
    _detailTextView.editable = NO;
    _detailTextView.Selectable = NO;
	_detailTextView.textColor = [UIColor whiteColor];
    [self addSubview:_detailTextView];
}


/*
UIImageView* _headerImageView;
UILabel* _nameLable;
StyleIndicatorView* _indicatorView;
UILabel* _distanceLable;
*/



@end
