//
//  Conversation.m
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Conversation.h"
#import "Message.h"



@implementation Conversation

@synthesize responder;
@synthesize messagesArray;

- (id) init {
    self = [super init];
    return self;
}

- (id) initWithResponder: (User *) responder {
    self = [self init];
    
    return self;
}

- (void) addMessageWithMessage: (Message *) message {
    
}

@end
