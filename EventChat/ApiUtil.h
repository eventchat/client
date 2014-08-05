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


@interface NSURLRequest (ApiUtil)

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

// Added by Lyman
+ (NSMutableURLRequest *) buildGetSessionRequest:(NSString *) parameters ;

// functions we'll need
+ (instancetype)requestWithPattern:(NSString *)string object:(id)object;
+ (instancetype)postRequest:(NSString *)string parameters:(NSDictionary *)parameters;
+ (instancetype)getRequest:(NSString *)string parameters:(NSDictionary *)parameters;
+ (instancetype)deleteRequest:(NSString *)string parameters:(NSDictionary *)parameters;
+ (instancetype)requestWithMethod:(NSString *)method
                              url:(NSString *)url
                       parameters:(NSDictionary *)parameters;
@end

@interface ApiUtil : NSObject

+ (void)saveCookiesWithId:(NSString *)mId;
+ (NSString *)loadCookies;
+ (NSString *)convertTimeStampWithUTCString: (NSString *)utcString;
@end
