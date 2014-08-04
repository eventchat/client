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


@implementation ECData

@synthesize conversationsDict;
@synthesize eventsDict;
@synthesize friendsDict;

- (ECData *) init {
    self = [super init];
    conversationsDict = [[NSMutableDictionary alloc] init];
    eventsDict = [[NSMutableDictionary alloc] init];
    friendsDict = [[NSMutableDictionary alloc] init];
    return self;
}

- (NSMutableDictionary *) getConversationsDict {
    return conversationsDict;
}

- (Conversation *) getConversationByUserId: (NSString *) responderId {
    return [conversationsDict objectForKey:responderId];
}

- (void) addConversationWithResponderId: (NSString *) responderId WithMessage: (Message *) message {
    if ([self getConversationByUserId:responderId] == Nil) {
        Conversation *newConversation = [[Conversation alloc] init];
        // add in the user as responder
        
        // add in the new message to the conversation
        [newConversation addMessageWithMessage:message];
    }
    else {
        [conversationsDict setObject:message forKey:responderId];
    }
    

}

- (NSMutableDictionary *) getEventsDict {
    return eventsDict;
}

- (void) addEvent {
    
}

- (NSMutableDictionary *) getFriendsDict {
    return friendsDict;
}

- (void) addFriend {
    
}


@end
