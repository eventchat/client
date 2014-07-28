//
//  Post.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Comment.h"
#import "ModelProtocol.h"

@interface Post : NSObject <ModelProtocol> {
    NSString *mId;
    NSString *mTitle;
    NSString *mType;
    NSString *mBody;
    NSString *mPic;
    NSString *mCreatedAt;
    User *mAuthor;
    NSMutableArray *mComments;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mTitle;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mPic;
@property (nonatomic, readwrite) NSString *mCreatedAt;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) NSMutableArray *mComments;

+ (instancetype) postWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments;

- (instancetype) initWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments;

@end
