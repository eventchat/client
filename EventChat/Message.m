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

+ (Message *) createMessageWithDictionary: (NSDictionary *) messageData {
//    NSDictionary *authorData = [messageData objectForKey:@"from"];
//    NSDictionary *receiverData = [messageData objectForKey:@"to"];
    NSString *messageBody = [messageData objectForKey:@"message"];
    NSString *messageTime = [messageData objectForKey:@"created_at"];

//    User *author = [[User alloc] initWithId:[authorData objectForKey:@"id"] withEmail:[authorData objectForKey:@"email"] withInfo:[authorData objectForKey:@"info"] withName:[authorData objectForKey:@"name"] withAvatarUrl:[authorData objectForKey:@"avatar_url"]];
    
    User *author = [User createUserWithDictionary:[messageData objectForKey:@"from"]];
    User *receiver = [User createUserWithDictionary:[messageData objectForKey:@"to"]];
    
//    User *receiver = [[User alloc] initWithId:[receiverData objectForKey:@"id"] withEmail:[receiverData objectForKey:@"email"] withInfo:[receiverData objectForKey:@"info"] withName:[receiverData objectForKey:@"name"] withAvatarUrl:[receiverData objectForKey:@"avatar_url"]];

    Message  *newMessage = [[Message alloc] initWithAuthor:author withReceiver:receiver withBody:messageBody withCreatedAt:messageTime];

    return newMessage;
}

- (NSDictionary *) toDictionary {
    NSDictionary *messageDict = [[NSDictionary alloc] initWithObjectsAndKeys: mBody, @"message", mReceiver.mId, @"to", nil];
    return messageDict;
}

- (id) initWithAuthor: (User *)author withReceiver: (User *)receiver withBody: (NSString *)body withCreatedAt: (NSString *)createdAt {
    self = [super init];
    mAuthor = [[User alloc] initWithId:author.mId withEmail:author.mEmail withInfo:author.mInfo withName:author.mName withAvatarUrl:author.mAvatarUrl];
    mReceiver = [[User alloc] initWithId:receiver.mId withEmail:receiver.mEmail withInfo:receiver.mInfo withName:receiver.mName withAvatarUrl:receiver.mAvatarUrl];
    mBody = [[NSString alloc] initWithString:body];
    mCreatedAt = [[NSString alloc] initWithString:createdAt];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Message: {mAuthor: %@\n mReceiver: %@\n mBody: %@\n mCreatedAt: %@}>", mAuthor, mReceiver, mBody, mCreatedAt];
}

@end
