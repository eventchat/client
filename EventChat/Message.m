//
//  Message.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Message.h"
#import "User.h"

@implementation Message

@synthesize mAuthor;
@synthesize mReceiver;
@synthesize mBody;
@synthesize mCreatedAt;

+ (Message *) createMessageWithData: (NSDictionary *) messageData withAppUser: (User *) appUser {
    Message *newMessage;
    NSString *authorId = [[messageData objectForKey:@"from"] objectForKey:@"id"];
    if ([authorId isEqualToString:appUser.mId]) {
        // sent-out message, author is appUser, receiver is 
        
    } else {
        // received message
    }
    return newMessage;
}

- (NSDictionary *) toDictionary {
    return nil;
}

- (id) initWithAuthor: (User *)author withReceiver: (User *)receiver withBody: (NSString *)body withCreatedAt: (NSString *)createdAt {
    self = [super init];
    mAuthor = [[User alloc] initWithId:author.mId withEmail:author.mEmail withInfo:author.mInfo withName:author.mName withAvatarUrl:author.mAvatarUrl];
    mReceiver = [[User alloc] initWithId:receiver.mId withEmail:receiver.mEmail withInfo:receiver.mInfo withName:receiver.mName withAvatarUrl:receiver.mAvatarUrl];
    mBody = [[NSString alloc] initWithString:body];
    mCreatedAt = [[NSString alloc] initWithString:createdAt];
    return self;
}

@end
