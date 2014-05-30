//
//  ApiUtil.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "User.h"
#import "Post.h"
#import "Event.h"
#import "Message.h"
#import "Notification.h"

@interface ApiUtil : NSObject

+ (NSMutableURLRequest *) buildGetUserRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildCreateUserRequest:(User *) user;

+ (NSMutableURLRequest *) buildGetPostRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildCreatePostRequest:(Post *) post;

+ (NSMutableURLRequest *) buildDeletePostRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildGetPostByUserRequest:(NSString *) userId;

+ (NSMutableURLRequest *) buildGetPostBySearchRequest:(double) latitude :(double) longitude :(NSInteger) maxDistance;

+ (NSMutableURLRequest *) buildCreateCommentToPostRequest:(NSString *) postId :(Comment *) comment;

+ (NSMutableURLRequest *) buildGetEventRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildCreateEventRequest:(Event *) event;

+ (NSMutableURLRequest *) buildCreateUpdateEventRequest:(Event *) event;

+ (NSMutableURLRequest *) buildDeleteEventRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildGetMessageByEventRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildGetNotificationRequest;

+ (NSMutableURLRequest *) buildReadNotificationByIdRequest:(NSString *) id;

+ (NSMutableURLRequest *) buildReadNotificationRequest;

@end
