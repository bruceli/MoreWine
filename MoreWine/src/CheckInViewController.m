//
//  CheckInViewController.m
//  MoreWine
//
//  Created by Thunder on 3/28/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "CheckInViewController.h"

#import "MaUtility.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController

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
    self.view.backgroundColor = [MaUtility getRandomColor];
    _infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, 320, 155)];
    _infoTextView.backgroundColor = [MaUtility getRandomColor];
    _infoTextView.contentInset = UIEdgeInsetsMake(-64.0f, 10.0f, 0.0f ,10.0f);
    _infoTextView.font = [UIFont systemFontOfSize:18.0f];
    _infoTextView.textColor = [UIColor whiteColor];
    _infoTextView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_infoTextView];
    
    [self setupShareView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupShareView
{
    UIView* shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+155, 320, 60)];
    UIView* topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
	topLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[shareView addSubview:topLineView];
    
    UIView* bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 1)];
	bottomLineView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0.2];
	[shareView addSubview:bottomLineView];
    
    UIImageView* shareIconView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 23, 14, 14)];
    shareIconView.backgroundColor = [MaUtility getRandomColor];
    [shareView addSubview:shareIconView];
    
    UILabel* shareToLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 23, 47, 14)];
    shareToLabel.font = [UIFont systemFontOfSize:14.0f];
    shareToLabel.textColor = [UIColor whiteColor];
    shareToLabel.backgroundColor = [MaUtility getRandomColor];
    shareToLabel.text = @"分享到:";
    [shareView addSubview:shareToLabel];
    
	UIButton* weChatButton = [[UIButton alloc] initWithFrame:CGRectMake(109, 8, 44, 44)];
	weChatButton.backgroundColor = [UIColor clearColor];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat"] forState:UIControlStateNormal];
	[weChatButton setBackgroundImage:[UIImage imageNamed:@"loginView_wechat_hilight"] forState:UIControlStateSelected];
	[shareView addSubview:weChatButton];
    
	UIButton* weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(161, 8, 44, 44)];
	weiboButton.backgroundColor = [UIColor clearColor];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo"] forState:UIControlStateNormal];
	[weiboButton setBackgroundImage:[UIImage imageNamed:@"loginView_weibo_hilight"] forState:UIControlStateSelected];
	[shareView addSubview:weiboButton];
    
    [self.view addSubview:shareView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
