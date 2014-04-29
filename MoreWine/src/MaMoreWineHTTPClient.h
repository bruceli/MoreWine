//
//  MaMoreWineHTTPClient.h
//  weather
//
//  Created by Thunder on 4/24/14.
//  Copyright (c) 2014 Thunder. All rights reserved.
//

#import "AFHTTPSessionManager.h"
@protocol MaMoreWineHTTPClientDelegate;

@interface MaMoreWineHTTPClient : AFHTTPSessionManager
@property (nonatomic, weak) id<MaMoreWineHTTPClientDelegate>delegate;
+ (MaMoreWineHTTPClient *)sharedMaMoreWineHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
-(void)signIn:(NSString*)userName password:(NSString*)password;
@end


@protocol MaMoreWineHTTPClientDelegate <NSObject>
@optional
-(void)MaMoreWineHTTPClient:(MaMoreWineHTTPClient *)client didFinishWithResponse:(id)response;
-(void)MaMoreWineHTTPClient:(MaMoreWineHTTPClient *)client didFailWithError:(NSError *)error;
@end