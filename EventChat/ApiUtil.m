//
//  ApiUtil.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ApiUtil.h"

@implementation ApiUtil

+ (NSMutableURLRequest *) buildGetUserRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_USER :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod: HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreateUserRequest:(User *) user {
    NSString *url = CREATE_USER;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[user toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildGetPostRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_POST_BY_USER_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreatePostRequest:(Post *) post {
    NSString *url = CREATE_POST;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString: url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[post toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildDeletePostRequest:(NSString *) id {
    NSString *url = [self buildUrlString:DELETE_POST_BY_POST_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetPostByUserRequest:(NSString *) userId {
    NSString *url = [self buildUrlString:GET_POST_BY_USER_ID :userId];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetPostBySearchRequest:(double) latitude :(double) longitude :(NSInteger) maxDistance {
    // TODO
    return nil;
}

+ (NSMutableURLRequest *) buildCreateCommentToPostRequest:(NSString *) postId :(Comment *) comment {
    NSString *url = [self buildUrlString:CREATE_COMMENT_TO_POST :postId];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_POST];
        [request setValuesForKeysWithDictionary:[comment toDictionary]];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_EVENT_BY_EVENT_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildCreateEventRequest:(Event *) event {
    NSString *url = CREATE_EVENT;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_POST];
    [request setValuesForKeysWithDictionary:[event toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildCreateUpdateEventRequest:(Event *) event {
    NSString *url = UPDATE_EVENT;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_PATCH];
    [request setValuesForKeysWithDictionary:[event toDictionary]];
    return request;
}

+ (NSMutableURLRequest *) buildDeleteEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:DELETE_EVENT :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_DELETE];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetMessageByEventRequest:(NSString *) id {
    NSString *url = [self buildUrlString:GET_MESSAGE_BY_EVENT_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_GET];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildGetNotificationRequest {
    NSString *url = GET_NOTIFICATION;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_GET];
    return request;
}

+ (NSMutableURLRequest *) buildReadNotificationByIdRequest:(NSString *) id {
    NSString *url = [self buildUrlString:READ_NOTIFICATION_BY_ID :id];
    if (url) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setHTTPMethod:HTTP_PATCH];
        return request;
    }
    return nil;
}

+ (NSMutableURLRequest *) buildReadNotificationRequest {
    NSString *url = READ_NOTIFICATION;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:HTTP_PATCH];
    return request;
}

+ (NSString *) buildUrlString:(NSString *) format :(NSString *) param {
    if (format) {
        return [HOST stringByAppendingString: [NSString stringWithFormat:format, param]];
    }
    return nil;
}

@end
