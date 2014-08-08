//
//  Message.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "ModelProtocol.h"

@interface Message : NSObject <ModelProtocol> {
    User *mAuthor;
    User *mReceiver;
    NSString *mBody;
    NSString *mCreatedAt;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) User *mReceiver;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mCreatedAt;

+ (Message *) createMessageWithDictionary: (NSDictionary *) messageData;
- (id) initWithAuthor: (User *)author withReceiver: (User *)receiver withBody: (NSString *)body withCreatedAt: (NSString *)createdAt;

@end
