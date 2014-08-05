//
//  ECData.h
//  EventChat
//
//  Created by Jianchen Tao on 8/3/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ECData : NSObject
@property User *mUser;
@property NSMutableDictionary *mConversationsDict;
@property NSMutableDictionary *mEventsDict;
@property NSMutableDictionary *mFriendsDict;

- (void) initUser: (User *) user;
- (void) setUser: (User *) user;

- (NSMutableDictionary *) getConversationsDict;

- (void) addConversationWithReceivedMessageArray: (NSArray *) messageArray;
@end
