//
//  SGFocusImageFrame.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import <objc/runtime.h>
//#import "AsyncImageView.h"

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
 
- (void)setupViews;
- (void)switchFocusImageItems;
@end

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 10.0; //switch interval time

@implementation SGFocusImageFrame
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItemArray:(NSArray*)itemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageItems = [[NSArray alloc] initWithArray:itemArray];
        
        [self setupViews];
        
        [self setDelegate:delegate]; 
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_imageItems release];
	[super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - private methods
- (void)setupViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    CGSize size = CGSizeMake(100, 44);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width *.5 - size.width *.5, self.bounds.size.height - size.height, size.width, size.height)];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    /*
    _scrollView.layer.cornerRadius = 10;
    _scrollView.layer.borderWidth = 1 ;
    _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
    */
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = _imageItems.count;
    _pageControl.currentPage = 0;
    
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageItems.count, _scrollView.frame.size.height);
    for (int i = 0; i < _imageItems.count; i++) {
		NSLog(@"%@",@"test");
        SGFocusImageItem *item = [_imageItems objectAtIndex:i];
		UIView* imageView = [[UIView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
		// set image here
		imageView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/(float)100 green:(arc4random()%100)/(float)100 blue:(arc4random()%100)/(float)100 alpha:0.3];
        [_scrollView addSubview:imageView];
        [imageView release];
    }
    [tapGestureRecognize release];
    
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < _imageItems.count) {
        SGFocusImageItem *item = [_imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
        }
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
  //  NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= _scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    _pageControl.currentPage = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    
}

@end
