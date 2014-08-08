//
//  Comment.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize mId;
@synthesize mAuthor;
@synthesize mBody;
@synthesize mCreatedAt;

- (NSDictionary *) toDictionary {
    return @{@"body": mBody};
}
- (id) initWithId: (NSString *) userId withAuthor:(User *) author withBody:(NSString *)body withCreatedAt:(NSString *)createdAt{
    self = [super init];
    if (self) {
        mId = userId;
        mAuthor = author;
        mBody = body;
        mCreatedAt = createdAt;
    }
    return self;
}
@end
