//
//  UIImagePickerController+StatusBarHidden.m
//  MoreWine
//
//  Created by Thunder on 14-5-7.
//  Copyright (c) 2014年 MagicApp. All rights reserved.
//

#import "UIImagePickerController+StatusBarHidden.h"

@implementation UIImagePickerController (StatusBarHidden)

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

-(UIViewController *) childViewControllerForStatusBarHidden
{
    return nil;
}

@end
