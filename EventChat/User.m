//
//  User.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "User.h"

// test cookie. Must be replaced!!!! current user Joe
NSString * const kCurrentUserKey = @"s%3Aj%3A%7B%22user%22%3A%7B%22id%22%3A%22538797bb940bf30200bdb649%22%2C%22name%22%3A%22joe%22%2C%22email%22%3A%22joe%40e.com%22%2C%22avatar_url%22%3Anull%2C%22info%22%3Anull%2C%22created_at%22%3A%222014-05-29T20%3A25%3A31.000Z%22%7D%7D.bl%2FLudR9RTRO6aKgBgwzgNZTnv7O%2FSSkLIcCG4EocV4";


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
