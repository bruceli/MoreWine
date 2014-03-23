//
//  ShopImagesCell.m
//  MoreWine
//
//  Created by Bruce Li on 3/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShopImagesCell.h"
#import "StyleIndicatorView.h"

@implementation ShopImagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initStyleIndicator];
    }
    return self;
}

-(void)initStyleIndicator
{
    //    -(StyleIndicatorView*)initStyleIndicatorViewWithFrame:(CGRect)inFrame ByDict:(NSDictionary*)dict
    CGRect frame = CGRectMake(190, 24, 95, 13);
    _indicatorView = [[StyleIndicatorView alloc] initStyleIndicatorViewWithFrame:frame ByDict:nil];
    _indicatorView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_indicatorView];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
