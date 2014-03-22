//
//  MaUtility.h
//  haitao
//
//  Created by Thunder on 3/13/13.
//  Copyright (c) 2013 magicApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MaCommunicatorCoding)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end


@interface MaUtility : NSObject
/*
+ (NSString*) URLDecodedString:(NSString *) string;
+ (NSString*) encodeingText:(NSString*)text;
+ (NSString*) encodeingBriefInfoText:(NSString*)text;
+ (NSString*) encodeingProductNameText:(NSString*)text;
//+ (void)fillText:(NSString*)inString to:(DTAttributedTextView*)view;

+ (CGFloat) estimateHeightBy:(NSString*)text image:(NSString*)imageURL;
+ (CGFloat) estimateHeightBy:(NSString*)text frame:(CGRect)rect;
 */
+ (UIColor*) getRandomColor;

+ (BOOL)hasFourInchDisplay;

+ (BOOL)isBundleFileExist:(NSString*) filePath;

+ (BOOL)isFileExist:(NSString*) filePath;

+ (BOOL)isValidEmailAddress:(NSString *)checkString;
/*
 + (void)showSuccessNotification:(NSString*)message inView:(UIView*)view;

+ (void)showErrorNotification:(NSString*)message inView:(UIView*)view;

+ (void)showHUDWithStatus:(NSString*)status;

+ (void)showSuccessHUDStatus:(NSString*)status;

+ (void)showFailedHUDStatus:(NSString*)status;

+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration;

+ (void)disableAllTouchEventInView:(UIView*)inView;

+ (void)enableAllTouchEventInView:(UIView*)inView;

+ (void)showHUDWaiting;

+ (void)dismissHUDWaiting;
 */
@end
