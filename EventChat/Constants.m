//
//  Constants.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Constants.h"

// Http
NSString *const HTTP_GET = @"GET";
NSString *const HTTP_POST = @"POST";
NSString *const HTTP_PATCH = @"PATCH";
NSString *const HTTP_DELETE = @"DELETE";

// Common key
NSString *const ID = @"id";
NSString *const NAME = @"name";
NSString *const BODY = @"body";
NSString *const CREATED_AT = @"created_at";
NSString *const AUTHOR = @"author";

// Key for user
NSString *const EMAIL = @"email";
NSString *const INFO = @"info";
NSString *const AVATAR_URL = @"avatar_url";

// Key for post
NSString *const TITLE = @"title";
NSString *const TYPE = @"type";

// Key for comment
// The same as common keys

// Key for event
NSString *const LONGITUDE = @"longitude";
NSString *const LATITUDE = @"latitude";
NSString *const START_TIME = @"start_time";
NSString *const END_TIME = @"end_time";
NSString *const DESCRIPTION = @"description";

// Key for message
// The same as common keys

// Key for notification
NSString *const IS_READ = @"is_read";

// API protocol
// Host
NSString *const HOST = @"http://eventchat.herokuapp.com";
NSString *const PORT = @"";
// User
NSString *const GET_USER = @"/users/%@";
NSString *const CREATE_USER = @"/users";
// Post
NSString *const GET_POST = @"/posts/%@";
NSString *const CREATE_POST = @"/posts";
NSString *const DELETE_POST_BY_POST_ID = @"/posts/%@";
NSString *const GET_POST_BY_USER_ID = @"/users/%@/posts";
NSString *const GET_POST_BY_SEARCH = @"/posts/search?latitude=%f&longitude=%f&max_distance=%d";
// Comment
NSString *const CREATE_COMMENT_TO_POST = @"/posts/%@/comments";
// Event
NSString *const GET_EVENT_BY_EVENT_ID = @"/events/%@";
NSString *const CREATE_EVENT = @"/events";
NSString *const UPDATE_EVENT = @"/events";
NSString *const DELETE_EVENT = @"/events/%@";
// Message
NSString *const GET_MESSAGE_BY_EVENT_ID = @"/events/%@/messages";
// Notification
NSString *const GET_NOTIFICATION = @"/notifications";
NSString *const READ_NOTIFICATION_BY_ID = @"/notifications/%@";
NSString *const READ_NOTIFICATION = @"/notifications";

