//
//  Conversation.m
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Conversation.h"
#import "Message.h"
#import "ApiUtil.h"



@implementation Conversation

@synthesize mResponder;
@synthesize mMessagesArray;

- (id) init {
    self = [super init];
    mResponder = [[User alloc] init];
    mMessagesArray = [[NSMutableArray alloc] init];
    return self;
}

- (id) initWithResponder: (User *) responder {
    self = [self init];
    mResponder = responder;
    return self;
}


- (void) addMessageWithMessage: (Message *) message {
    [mMessagesArray addObject:message];
}

- (NSString *) getMostRecentMessageTime {
    Message *mostRecentMessage = [mMessagesArray lastObject];
    return [ApiUtil convertTimeStampWithUTCString:mostRecentMessage.mCreatedAt];
}

- (NSString *) getMostRecentMessageBody {
    Message *mostRecentMessage = [mMessagesArray lastObject];
    return mostRecentMessage.mBody;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Conversation: {mResponder: %@\n Number of Messages: %lu}>", mResponder, (unsigned long)[mMessagesArray count]];
}


@end
