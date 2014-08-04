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

- (id) initWithId: (NSString *) userId withEmail: (NSString *) email withInfo: (NSString *) info withName: (NSString *)name withAvatarUrl: (NSString *) avatarUrl {
    self = [self init];
    mId = [[NSString alloc] initWithString:userId];
    mEmail = [[NSString alloc] initWithString:email];
    mInfo = [[NSString alloc] initWithString:info];
    mName = [[NSString alloc] initWithString:name];
    mAvatarUrl = [[NSString alloc] initWithString:avatarUrl];
    return self;
}

- (void) copy: (User *)user {
    mId = [NSString stringWithString:user.mId];
    mEmail = [NSString stringWithString:user.mEmail];
    mInfo = [NSString stringWithString:user.mInfo];
    mName = [NSString stringWithString:user.mName];
    mAvatarUrl = [NSString stringWithString:user.mAvatarUrl];
}

- (NSDictionary *) toDictionary {
    return nil;
}


@end
