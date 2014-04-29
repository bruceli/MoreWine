//
//  Ma7TimeSessionManager.m
//  weather
//
//  Created by Thunder on 4/24/14.
//  Copyright (c) 2014 Thunder. All rights reserved.
//

#import "MaMoreWineHTTPClient.h"
static NSString * const WorldWeatherOnlineAPIKey = @"PASTE YOUR API KEY HERE";
static NSString * const Ma7TimerURLString = @"http://www.7timer.com/v4/bin/";

@implementation MaMoreWineHTTPClient

+ (MaMoreWineHTTPClient *)sharedMaMoreWineHTTPClient
{
    static MaMoreWineHTTPClient *_sharedMaMoreWineHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMaMoreWineHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:Ma7TimerURLString]];
    });
    
    return _sharedMaMoreWineHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet* theSet = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
        [theSet addObject: @"text/html"];
        self.responseSerializer.acceptableContentTypes = theSet;
        //        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];

    
    return self;
}

-(void)signIn:(NSString*)userName password:(NSString*)password
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
//    parameters[@"num_of_days"] = @(number);
//    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    parameters[@"lon"] = [NSNumber numberWithFloat:108.987f];
    parameters[@"lat"] = [NSNumber numberWithFloat:34.314f];
    parameters[@"product"] = @"astro";
    parameters[@"output"] = @"json";

    //    parameters[@"key"] = WorldWeatherOnlineAPIKey;
    
    [self GET:@"api.pl" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(MaMoreWineHTTPClient:didFinishWithResponse:)]) {
            [self.delegate MaMoreWineHTTPClient:self didFinishWithResponse:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(MaMoreWineHTTPClient:didFailWithError:)]) {
            [self.delegate MaMoreWineHTTPClient:self didFailWithError:error];
        }
    }];
}


@end
