//
//  ECData.m
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ECData.h"
#import "Message.h"
#import "Conversation.h"
#import "Event.h"


@implementation ECData
@synthesize mUser;
@synthesize mConversationsDict;
@synthesize mEventsDict;
@synthesize mFriendsDict;

- (ECData *) init {
    self = [super init];
    mConversationsDict = [[NSMutableDictionary alloc] init];
    mEventsDict = [[NSMutableDictionary alloc] init];
    mFriendsDict = [[NSMutableDictionary alloc] init];
    return self;
}

- (ECData *) initWithUser: (User *) user {
    self = [self init];
    self.mUser = user;
    return self;
}

- (NSMutableDictionary *) getConversationsDict {
    return mConversationsDict;
}

- (Conversation *) getConversationByUserId: (NSString *) responderId {
    return [mConversationsDict objectForKey:responderId];
}

- (void) addConversationWithMessage: (Message *) message {
    User *responder;
    BOOL receivedMessage; // TRUE for received message; FALSE for sent-out message
    if ([message.mAuthor.mId isEqual:mUser.mId]) {
        // sent-out message
        receivedMessage = FALSE;
        responder = message.mReceiver;
    }
    else {
        // received message
        receivedMessage = TRUE;
        responder = message.mAuthor;
    }
    if ([self getConversationByUserId:responder.mId]) {
        // if responder already in conversation list, add message into corresponding conversation
        [[mConversationsDict objectForKey:responder.mId] addMessageWithMessage:message];
    }
    else {
        // if responder not in conversation list:
        // create new conversation with responder then add the message into it;
        // add the created conversation into mConversationDict
        Conversation *newConversation = [[Conversation alloc] initWithResponder:responder];
        [newConversation addMessageWithMessage:message];
        [mConversationsDict setObject:newConversation forKey:responder.mId];
    }
}

- (NSMutableDictionary *) getEventsDict {
    return mEventsDict;
}

- (void) addEvent: (Event *)event {
    [mEventsDict setObject:event forKey:event.mId];
}

- (NSMutableDictionary *) getFriendsDict {
    return mFriendsDict;
}

- (void) addFriend {
    
}


@end
