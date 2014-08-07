//
//  Post.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Post.h"

@implementation Post

@synthesize mId = _mId;
@synthesize mTitle = _mTitle;
@synthesize mAuthor = _mAuthor;
@synthesize mBody = _mBody;
@synthesize mPic = _mPic;
@synthesize mCreatedAt = _mCreatedAt;
@synthesize mComments = _mComments;
@synthesize mType = _mType;
@synthesize mLikes = _mLikes;

- (NSDictionary *) toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    result[@"title"] = _mTitle;
    result[@"type"] = _mType;
    
    result[@"body"] = _mBody;
    result[@"event_id"] = _mEvent.mId;
    return [result copy];
}

+ (instancetype) postWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments withLikes:(NSMutableArray *) likes withType:(NSString *)type withEvent:(Event *)event{
    
    return [[Post alloc] initWithId:postId withTitle:title withAuthor:author withBody:body withPic:pic withCreatedAt:createdAt withComments:comments withType:type withEvent:event];
}

- (instancetype) initWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments withLikes:(NSMutableArray *) likes withType:(NSString *)type withEvent:(Event *)event{
    self = [super init];
    if (self) {
        _mId = postId;
        _mTitle = title;
        _mAuthor = author;
        _mBody = body;
        _mPic = pic;
        _mCreatedAt = createdAt;
        _mComments = [comments copy];
        _mLikes = [likes copy];
        _mType = type;
        _mEvent = event;
    }
    return self;
}

@end
