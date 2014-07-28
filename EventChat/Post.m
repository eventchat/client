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

- (NSDictionary *) toDictionary {
    return nil;
}

+ (instancetype) postWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments {
    return [[Post alloc] initWithId:postId withTitle:title withAuthor:author withBody:body withPic:pic withCreatedAt:createdAt withComments:comments];
}

- (instancetype) initWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments {
    self = [super init];
    if (self) {
        _mId = postId;
        _mTitle = title;
        _mAuthor = author;
        _mBody = body;
        _mPic = pic;
        _mCreatedAt = createdAt;
        _mComments = comments;
    }
    return self;
}

@end
