//
//  TagManagerViewController.m
//  MoreWine
//
//  Created by Thunder on 4/29/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "TagManagerViewController.h"
#import "MaUtility.h"
#import "MaTagButton.h"
#import "TagListViewController.h"

@interface TagManagerViewController ()

@end

@implementation TagManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _editMode = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [MaUtility getRandomColor];
    _scrollView.alwaysBounceVertical = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubview:_scrollView];
    [self setupNavBarItems];
    //[self setupTags:nil];
    
    _addTagButton = [[UIButton alloc] initWithFrame:CGRectMake(17, 17, 286, 32)];
    [_addTagButton addTarget:self action:@selector(addTagAction:) forControlEvents:UIControlEventTouchUpInside];
    [_addTagButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[_addTagButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[_addTagButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];
    
	_addTagButton.layer.cornerRadius=4.0f;
    _addTagButton.layer.masksToBounds=YES;
    _addTagButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    _addTagButton.layer.borderWidth= 0.7f;
	[_addTagButton setTitle:@"添加标签" forState:UIControlStateNormal];
	_addTagButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_scrollView addSubview:_addTagButton];

    // V1.1
    [self setupTagButtonsByTitleArray:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupNavBarItems
{
//    UIImage *backImage = [UIImage imageNamed:@"navigation_Back_Icon"];
//	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, backImage.size.width, backImage.size.height)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, 80,40)];
	button.backgroundColor = [UIColor clearColor];
	[button addTarget:self action:@selector(deleteTags:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"删除标签" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
//	[button setBackgroundImage:backImage forState:UIControlStateNormal];
	//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	negativeSpacer.width = -16;// it was -6 in iOS 6
	[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:button]/*this will be the button which u actually need*/, nil] animated:NO];
}

-(void)setupTagButtonsByTitleArray:(NSArray*)titleArray
{
    NSArray* array = [NSArray arrayWithObjects:@"TE111",@"TE2222222", @"TEEEEEEEE555", @"TEEss6", @"the TEEEEEeeeeeeE 7", nil];

    _tagButtonArray = [[NSMutableArray alloc] init];
    CGRect initFrame = CGRectMake(0, 0, 0, 28); //button hight only
    for (NSString* string in array) {
        MaTagButton *theButton = [[MaTagButton alloc] initWithFrame:initFrame title:string];
        [theButton sizeToFit];
        [theButton addTarget:self action:@selector(didTapTagButton:) forControlEvents:UIControlEventTouchUpInside];

        [_tagButtonArray addObject:theButton];
    }
    
    [self arrangementTagButtons];

    for (MaTagButton* theButton in _tagButtonArray) {
        [_scrollView addSubview:theButton];
    }
}

-(void)arrangementTagButtons
{
    CGFloat editModeGap = 0.0f;
    
    CGPoint initPoint = CGPointMake(17, 58);
    CGFloat maxX = self.view.frame.size.width - 34;
	CGFloat xGap = 0;
	CGFloat yGap = 32; // button hight + 4;
    CGPoint buttonPoint;
    CGRect finalFrame = CGRectMake(initPoint.x, initPoint.y, 0, 0);
    NSMutableArray* finalButtonArray = [[NSMutableArray alloc] init];
    
    for (MaTagButton *theButton in _tagButtonArray) {
		CGFloat buttonMaxX = theButton.frame.size.width + finalFrame.origin.x + finalFrame.size.width + xGap + editModeGap ;
		if ( buttonMaxX > maxX ) // check if out of the screen
		{
            buttonPoint = CGPointMake(initPoint.x, finalFrame.origin.y + yGap);
		}
		else
		{
			buttonPoint = CGPointMake(finalFrame.origin.x + finalFrame.size.width + xGap + editModeGap   , finalFrame.origin.y);
            if (_editMode)
                editModeGap = MA_TagButton_editMode_Gap;

			xGap = 4; // align first line
        }
        
        finalFrame = CGRectMake(buttonPoint.x, buttonPoint.y, theButton.frame.size.width, theButton.frame.size.height);
        
        if (!_editMode) {
            theButton.frame = finalFrame;
        }
        else
        [UIView animateWithDuration:0.25f delay:0.0f
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{ theButton.frame = finalFrame; } completion:nil];
        
        [finalButtonArray addObject:theButton];
    }
    
    [_tagButtonArray removeAllObjects];
    [_tagButtonArray addObjectsFromArray:finalButtonArray];
    [finalButtonArray removeAllObjects];
    
    CGFloat bottomLineY = finalFrame.origin.y + finalFrame.size.height + 15;
    CGSize theSize = CGSizeMake(_scrollView.frame.size.width, bottomLineY);
    _scrollView.contentSize = theSize;

}


-(void)didTapTagButton:(id)sender
{
    if (!_editMode)
    {
        NSString* titleString = ((MaTagButton*)sender).titleString;
  /*      if ([titleString isEqualToString:@"MA_ADD_TAG_BUTTON"]) {
            [self addTagAction:sender];
        }
        else*/
        {
            TagListViewController* viewController = [[TagListViewController alloc] initWithTag: titleString];
            [self.navigationController pushViewController: viewController animated:YES];
        }
    }
    else // in edit Mode
    {
        [((MaTagButton*)sender) reverseTagStatus];
    }
}

#pragma mark - add Tag

-(void)addTagAction:(id)sender
{
    NSLog(@"tagMgr add tag height is %f ", self.view.bounds.size.height);

	_addTagView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*2, self.view.bounds.size.width, self.view.bounds.size.height)];
	_addTagView.backgroundColor = [MaUtility getRandomColor];
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAddTagView:)];
	singleTap.numberOfTapsRequired = 1;
	[_addTagView setUserInteractionEnabled:YES];
    [_addTagView addGestureRecognizer:singleTap];
    
	UITextField* theField = [[UITextField alloc] initWithFrame:CGRectMake(17, 50, 286, 40)];
	theField.borderStyle = UITextBorderStyleNone;
	theField.backgroundColor = [UIColor clearColor];
    theField.layer.cornerRadius=4.0f;
    theField.layer.masksToBounds=YES;
    theField.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theField.layer.borderWidth= 1.0f;
	UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
	theField.leftView = namePaddingView;
	theField.leftViewMode = UITextFieldViewModeAlways;
    //	theField.delegate = self;
    theField.textColor = [UIColor lightGrayColor];
	theField.returnKeyType = UIReturnKeyDone;
	theField.text = NSLocalizedString(@"新标签", nil);
	[_addTagView addSubview:theField];
    
	UIButton *theButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 100, 140, 40)];
	theButton.layer.cornerRadius=4.0f;
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 1.0f;
    theButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [theButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
	[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];
    
	[theButton setTitle:NSLocalizedString(@"增加标签", nil) forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(addTag:) forControlEvents:UIControlEventTouchUpInside];
	[_addTagView addSubview:theButton];
	[self.view addSubview:_addTagView];
    
	CGRect toFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[UIView animateWithDuration:0.25f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _addTagView.frame = toFrame;
						 _addTagView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)dismissAddTagView:(id)sender
{
	CGRect toFrame = CGRectMake(0, self.view.bounds.size.height*2, 320, self.view.bounds.size.height);
	[UIView animateWithDuration:0.3f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _addTagView.frame = toFrame;
						 _addTagView.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished){
						 [_addTagView removeFromSuperview];
                         
                     }];
}

-(void)addTag:(id)sender
{
	[self dismissAddTagView:nil];
}

#pragma mark - delete Tags
-(void)deleteTags:(id)sender
{
    UIButton *theButton = (UIButton*)sender;

    if (!_editMode) {
        [theButton setTitle:@"删除" forState:UIControlStateNormal];
        [theButton removeTarget:self action:@selector(deleteTags:) forControlEvents:UIControlEventTouchUpInside];
        [theButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _editMode = YES;
    
    for (MaTagButton* theTag in _tagButtonArray) {
        [theTag setEditMode];
    }
    
    _addTagButton.enabled=NO;
    _addTagButton.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
}

-(void)delete:(id)sender
{
    _editMode = NO;
    UIButton *theButton = (UIButton*)sender;

    [theButton setTitle:@"删除标签" forState:UIControlStateNormal];
    [theButton removeTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [theButton addTarget:self action:@selector(deleteTags:) forControlEvents:UIControlEventTouchUpInside];

    NSMutableArray* markedArray = [[NSMutableArray alloc] init];
    for (MaTagButton *tagButton in _tagButtonArray) {
        if (tagButton.tagStatus == MA_TagButtonStatus_EditMode_Marked) {
            [markedArray addObject:tagButton];
        }
    }
    
    [UIView animateWithDuration:0.3f delay:0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         for (MaTagButton* tagButton in markedArray) {
                             [tagButton removeFromSuperview];
                         }
                     }
                     completion:^(BOOL finished){
                         [_tagButtonArray removeObjectsInArray:markedArray];
                         [self arrangementTagButtons];
                         
                         _addTagButton.enabled=YES;
                         _addTagButton.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];

                     }];
    
}


#pragma mark - Button status helper

-(void)buttonHighlight:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 2.0f;
}

-(void)buttonNormal:(id)sender
{
	UIButton* theButton = (UIButton*)sender;
	theButton.backgroundColor = [UIColor clearColor];
    theButton.layer.masksToBounds=YES;
    theButton.layer.borderColor=[[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    theButton.layer.borderWidth= 1.0f;
}



@end
