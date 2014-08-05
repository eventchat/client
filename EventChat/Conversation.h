//
//  Conversation.h
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "User.h"

@interface Conversation : NSObject

@property User *mResponder;
@property NSMutableArray *mMessagesArray;

- (id) initWithResponder: (User *) responder;
- (void) addMessageWithMessage: (Message *) message;

- (NSString *) getMostRecentMessageTime;
- (NSString *) getMostRecentMessageBody;
@end
