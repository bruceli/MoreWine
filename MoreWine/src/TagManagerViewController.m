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
    [self.view addSubview:_scrollView];
    [self setupNavBarItems];
    [self setupTags:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupNavBarItems
{
    UIImage *backImage = [UIImage imageNamed:@"navigation_Back_Icon"];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, 0.0f, backImage.size.width, backImage.size.height)];
	button.backgroundColor = [MaUtility getRandomColor];
	[button addTarget:self action:@selector(deleteTags) forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:backImage forState:UIControlStateNormal];
	//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	negativeSpacer.width = -16;// it was -6 in iOS 6
	[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:button]/*this will be the button which u actually need*/, nil] animated:NO];
}


-(void)setupTags:(NSArray*)tagArray
{
    _tagButtonArray = [[NSMutableArray alloc] init];
	NSArray* array = [NSArray arrayWithObjects:@"TE111",@"TE2222222", @"TEEEEEEEE555", @"TEEss6", @"the TEEEEEeeeeeeE 7",@"MA_ADD_TAG_BUTTON", nil];
	
	// X = 17
	CGRect frame = CGRectMake(17, 38, 0, 22);
	CGRect buttonFrame;
	CGFloat maxWidth = self.view.frame.size.width - 34;
	CGFloat xGap = 0;
	CGFloat yGap = 26; // button hight + 4;
    //	BOOL isNewLine = YES;
    
	for (NSString* string in array) {
		CGFloat width = [MaTagButton buttonWidthWithTitle:string];
		CGFloat buttonWidth = width + frame.origin.x + frame.size.width + xGap;
		if ( buttonWidth > maxWidth ) // check if out of the screen
		{
			buttonFrame = CGRectMake(17, frame.origin.y + yGap, width, frame.size.height);
		}
		else
		{
			// seems good
			buttonFrame = CGRectMake(frame.origin.x + frame.size.width + xGap , frame.origin.y, width, frame.size.height);
			xGap = 4; // align first line
        }
        //		NSLog(@"theFrame is %@", NSStringFromCGRect(buttonFrame));
		UIButton *theButton = [[MaTagButton alloc] initWithFrame:buttonFrame title:string];
		[theButton addTarget:self action:@selector(didTapTagButton:) forControlEvents:UIControlEventTouchUpInside];
		[theButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
		[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
		[theButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchDragOutside];
        
		frame = buttonFrame;
        [_tagButtonArray addObject:theButton];
		[_scrollView addSubview:theButton];
	}
	
	CGFloat bottomLineY = frame.origin.y + frame.size.height + 15;
    CGSize theSize = CGSizeMake(_scrollView.frame.size.width, bottomLineY);
    _scrollView.contentSize = theSize;
//	_tagView.frame = CGRectMake(tagFrame.origin.x, tagFrame.origin.y, tagFrame.size.width, bottomLineY);
}

-(void)didTapTagButton:(id)sender
{
    if (!_editMode)
    {
        NSString* titleString = ((MaTagButton*)sender).titleString;
        if ([titleString isEqualToString:@"MA_ADD_TAG_BUTTON"]) {
            [self addTagAction:sender];
        }
        else
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
    
	CGRect toFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
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
-(void)deleteTags
{
    _editMode = YES;
    for (MaTagButton* theTag in _tagButtonArray) {
        [theTag setEditMode];
    }
    
    MaTagButton* addbutton =[_tagButtonArray lastObject];
    addbutton.enabled=NO;
    addbutton.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
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
