//
//  Constants.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

// Http
extern NSString *const HTTP_GET;
extern NSString *const HTTP_POST;
extern NSString *const HTTP_PATCH;
extern NSString *const HTTP_DELETE;

// Common key
extern NSString *const ID;
extern NSString *const NAME;
extern NSString *const BODY;
extern NSString *const CREATED_AT;
extern NSString *const AUTHOR;

// Key for session
extern NSString *const SESSION;

// Key for user
extern NSString *const EMAIL;
extern NSString *const INFO;
extern NSString *const AVATAR_URL;

// Key for post
extern NSString *const TITLE;
extern NSString *const TYPE;

// Key for comment
// The same as common keys

// Key for event
extern NSString *const LONGITUDE;
extern NSString *const LATITUDE;
extern NSString *const START_TIME;
extern NSString *const END_TIME;
extern NSString *const DESCRIPTION;

// Key for message
// The same as common keys

// Key for notification
extern NSString *const IS_READ;

// API protocol
// Host
extern NSString *const HOST;
extern NSString *const PORT;
// User
extern NSString *const GET_USER;
extern NSString *const CREATE_USER;
// Post
extern NSString *const GET_POST;
extern NSString *const CREATE_POST;
extern NSString *const DELETE_POST_BY_POST_ID;
extern NSString *const GET_POST_BY_USER_ID;
extern NSString *const GET_POST_BY_SEARCH;
// Comment
extern NSString *const CREATE_COMMENT_TO_POST;
// Event
extern NSString *const GET_EVENT_BY_EVENT_ID;
extern NSString *const CREATE_EVENT;
extern NSString *const UPDATE_EVENT;
extern NSString *const DELETE_EVENT;
// Message
extern NSString *const GET_MESSAGE_BY_EVENT_ID;
// Notification
extern NSString *const GET_NOTIFICATION;
extern NSString *const READ_NOTIFICATION_BY_ID;
extern NSString *const READ_NOTIFICATION;

