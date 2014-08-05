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
@property NSMutableArray *mEvents;
@property NSMutableDictionary *mFriendsDict;
@property NSString *mId; // user's id, now for temporary usage

- (void) initUser: (User *) user;
- (void) setUser: (User *) user;

- (NSMutableDictionary *) getConversationsDict;

- (void) addConversationWithReceivedMessageArray: (NSArray *) messageArray;
@end
