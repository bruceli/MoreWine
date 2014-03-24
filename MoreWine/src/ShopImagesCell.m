//
//  ShopImagesCell.m
//  MoreWine
//
//  Created by Bruce Li on 3/11/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "ShopImagesCell.h"
#import "SGFocusImageItem.h"

#define Shop_Image_View_Height 154

@implementation ShopImagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupHilightImageView];
    }
    return self;
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

-(void)setupHilightImageView
{
	NSMutableArray* _scrollingArray = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
	
	NSMutableArray* scrItemArray = [[NSMutableArray alloc] init];
	if( [_scrollingArray count]>0){
		for (int i = 0; i < [_scrollingArray count] ; i++) {
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"title" image:@"" targetURL:@""  tag:i];
			NSLog(@"%@",@"create SGFocusImageItem");
            //	SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:[[dict objectForKey:@"title"] URLDecodedString] image:[[dict objectForKey:@"smallimg"] URLDecodedString] targetURL:[[dict objectForKey:@"link"] URLDecodedString]  tag:i];
			[scrItemArray addObject:item];
		}
	}
	SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Shop_Image_View_Height) delegate:self focusImageItemArray:scrItemArray];
    _shopImageView = imageFrame;
    [self.contentView addSubview:_shopImageView];
}


#pragma mark - SGFocusImageFrameDelegate

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    
}

@end
