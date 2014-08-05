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
    if (userId) {
        mId = [[NSString alloc] initWithString:userId];
    }
    if (email) {
        mEmail = [[NSString alloc] initWithString:email];
    }
    if (![info isKindOfClass:[NSNull class]]) {
        mInfo = [[NSString alloc] initWithString:info];
    } else {
        // handle null case
        mInfo = @"";
    }
    if (name) {
        mName = [[NSString alloc] initWithString:name];
    }
    if (![avatarUrl isKindOfClass:[NSNull class]]) {
        mAvatarUrl = [[NSString alloc] initWithString:avatarUrl];
    } else {
        // handle null case
        mAvatarUrl = @"";
    }
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

- (NSString *)description {
    return [NSString stringWithFormat:@"<User: {mId: %@\n mEmail: %@\n mInfo: %@\n mName: %@\n mAvatarUrl: %@}>", mId, mEmail, mInfo, mName, mAvatarUrl];
}




@end
