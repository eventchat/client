//
//  ChatMessage.h
//  EventChat
//
//  Created by Jianchen Tao on 7/9/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject

+ (instancetype)messageWithString: (NSString *)message;
+ (instancetype)messageWithString:(NSString *)message image:(UIImage *)image;

- (instancetype)initWithString: (NSString *)message;
- (instancetype)initWithString:(NSString *)message image:(UIImage *)image;

@property (nonatomic, copy)NSString *message;
@property (nonatomic, strong)UIImage *avatar;

@end
