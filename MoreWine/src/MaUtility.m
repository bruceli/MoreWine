//
//  MaUtility.m
//  haitao
//
//  Created by Thunder on 3/13/13.
//  Copyright (c) 2013 magicApp. All rights reserved.
//

#import "MaUtility.h"
//#import "SVProgressHUD.h"

@implementation NSString (MaCommunicatorCoding)
- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
	CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding);
  	NSString* string = (NSString*)CFBridgingRelease(strRef);
	return string;
}

- (NSString *)URLEncodedString
{
	return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}


- (NSString*) URLDecodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
	return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,  (CFStringRef)[self mutableCopy], CFSTR(""), encoding);
} 

- (NSString *)URLDecodedString
{
	return [self URLDecodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

@end


@implementation MaUtility
+ (NSString*) URLDecodedString:(NSString *) string {
//	return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef) string, CFSTR(""), kCFStringEncodingUTF8);
	NSString *result = [[string stringByReplacingOccurrencesOfString:@"+" withString:@" "]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return result;
} 

+ (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

+ (BOOL)isBundleFileExist:(NSString*) filePath{
	// Return YES if address is a URL 
	if ([filePath hasPrefix:@"http://"])
		return YES;
	
	NSString* theFilePathString = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filePath];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:theFilePathString];
	return fileExists;
}

+ (BOOL)isFileExist:(NSString*) filePath{
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
	return fileExists;
}

+ (BOOL) isValidEmailAddress:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

/*
+(void)showSuccessNotification:(NSString*)message inView:(UIView*)view
{
    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:view title:message];
    [notice show];
}


+(void)showErrorNotification:(NSString*)message inView:(UIView*)view
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:view title:@"错误" message:message];
    [notice show];
    
}

+ (void)showHUDWithStatus:(NSString*)status
{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showSuccessHUDStatus:(NSString*)status
{
	[SVProgressHUD dismissWithSuccess:status];
}

+ (void)showFailedHUDStatus:(NSString*)status
{
	[SVProgressHUD dismissWithError:status];
}

+(void)enableAllTouchEventInView:(UIView*)inView
{
    inView.userInteractionEnabled = YES;
}

+(void)disableAllTouchEventInView:(UIView*)inView
{
    inView.userInteractionEnabled = NO;
}

+ (void)showHUDWaiting
{
    [SVProgressHUD show];
}

+ (void)dismissHUDWaiting
{
    [SVProgressHUD dismiss];
}

+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration
{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:string afterDelay:duration];
}
 */

@end
