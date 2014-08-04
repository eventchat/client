//
//  ECData.m
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ECData.h"
#import "Message.h"

NSMutableDictionary *conversationsDict;
NSMutableDictionary *eventsDict;
NSMutableDictionary *friendsDict;

@implementation ECData

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


- (void) addConversationWithResponderId: (NSString *) responderId WithMessage: (Message *) message {
    
    
    [conversationsDict setObject:message forKey:responderId];
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
