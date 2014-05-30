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
    NSString *mCreatedAt;
    User *mAuthor;
    NSMutableArray *mComments;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mTitle;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mCreatedAt;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) NSMutableArray *mComments;

@end
