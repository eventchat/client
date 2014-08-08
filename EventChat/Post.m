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

+ (instancetype) createPostWithData: (NSDictionary *) postData {
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    for (NSDictionary *commentData in [postData objectForKey:@"comments"]) {
        [comments addObject:[Comment createCommentWithDictionary:commentData]];
    }
    
    NSMutableArray *liked_by = [[NSMutableArray alloc] init];
    for (NSDictionary *likedUserData in [postData objectForKey:@"liked_by"]) {
        [liked_by addObject:[User createUserWithDictionary:likedUserData]];
    }
    
    
    return [[Post alloc] initWithId:[postData objectForKey:@"id"] withTitle:[postData objectForKey:@"title"] withAuthor:[User createUserWithDictionary:[postData objectForKey:@"author"]] withBody:[postData objectForKey:@"body"] withPic:nil withCreatedAt:[postData objectForKey:@"created_at"] withComments:comments withLikes:liked_by withType:[postData objectForKey:@"type"] withEvent:[Event createEventwithDictionary:[postData objectForKey:@"event"]]];
}

+ (instancetype) postWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments withLikes:(NSMutableArray *) likes withType:(NSString *)type withEvent:(Event *)event{
    
    return [[Post alloc] initWithId:postId withTitle:title withAuthor:author withBody:body withPic:pic withCreatedAt:createdAt withComments:comments withLikes:(NSMutableArray *) likes withType:type withEvent:event];
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

- (NSString *)description {
    return [NSString stringWithFormat:@"<Post: {mId: %@\n mTitle: %@\n mAuthor: %@\n mBody: %@\n mPic: %@\n mCreatedAt: %@\n mComments: %@\n mLikes: %@\n mType: %@\n mEvent: %@\n}>", _mId, _mTitle, _mAuthor, _mBody, _mPic, _mCreatedAt, _mComments, _mLikes, _mType, _mEvent];
}

@end
