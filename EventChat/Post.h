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
#import "Event.h"
#import "ModelProtocol.h"

@interface Post : NSObject <ModelProtocol>

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mTitle;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mPic;
@property (nonatomic, readwrite) NSString *mCreatedAt;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) NSMutableArray *mComments;
@property (nonatomic, readwrite) NSMutableArray *mLikes;

// added by Lyman
@property (nonatomic, readwrite) NSString *mType;
@property (nonatomic, readwrite) Event *mEvent;

+ (instancetype) createPostWithData: (NSDictionary *) postData;

+ (instancetype) postWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments withLikes:(NSMutableArray *) likes withType:(NSString *)type withEvent:(Event *)event;

- (instancetype) initWithId: (NSString *)postId withTitle:(NSString *)title withAuthor:(User *)author withBody:(NSString *)body withPic: (NSString *) pic withCreatedAt: (NSString *)createdAt withComments:(NSMutableArray *) comments withLikes:(NSMutableArray *) likes withType:(NSString *)type withEvent:(Event *)event;

@end
