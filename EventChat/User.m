//
//  User.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize mId;
@synthesize mEmail;
@synthesize mInfo;
@synthesize mName;
@synthesize mAvatarUrl;

- (id) init{
    if(self = [super init]){
        // to be implemented avatar
    }
    return self;
}
- (NSDictionary *) toDictionary {
    return nil;
}

@end
