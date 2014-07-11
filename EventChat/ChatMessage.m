//
//  ChatMessage.m
//  EventChat
//
//  Created by Jianchen Tao on 7/9/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

+ (instancetype)messageWithString:(NSString *)message {
    return [ChatMessage messageWithString:message image:nil];
}

+ (instancetype)messageWithString:(NSString *)message image:(UIImage *)image {
    return [[ChatMessage alloc] initWithString:message image:image];
}

- (instancetype)initWithString:(NSString *)message {
    return [self initWithString:message image:nil];
}

- (instancetype)initWithString:(NSString *)message image:(UIImage *)image {
    self = [super init];
    if (self) {
        _message = message;
        _avatar = image;
    }
    return self;
}

@end
