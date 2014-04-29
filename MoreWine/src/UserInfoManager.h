//
//  UserInfoManager.h
//  MoreWine
//
//  Created by Thunder on 3/26/14.
//  Copyright (c) 2014 MagicApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaMoreWineHTTPClient.h"

@interface UserInfoManager : NSObject <MaMoreWineHTTPClientDelegate>
{
}

-(BOOL)isLogIn;


@end
