//
//  Message.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize mId;
@synthesize mAuthor;
@synthesize mReceiver;
@synthesize mBody;
@synthesize mCreatedAt;

- (NSDictionary *) toDictionary {
    return nil;
}

@end
