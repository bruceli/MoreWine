//
//  UserInfoManager.m
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import "UserInfoManager.h"
#import "MaMoreWineHTTPClient.h"

@implementation UserInfoManager
-(id)init
{
    self = [super init];
	if (self) {
	}
	return self;
}

-(BOOL)isLogIn
{
    return YES;
}

-(void)signInWithUserName:(NSString*)userName password:(NSString*)password
{
    MaMoreWineHTTPClient *client = [MaMoreWineHTTPClient sharedMaMoreWineHTTPClient];
    client.delegate = self;
    [client signIn:userName password:password];
}


#pragma mark - Ma7TimeHTTPClient

- (void)MaMoreWineHTTPClient:(MaMoreWineHTTPClient *)client didFinishWithResponse:(id)response
{

}

- (void)MaMoreWineHTTPClient:(MaMoreWineHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    // error domain = NSURLErrorDomain Code = -1001 "The request timed out."
}


@end
