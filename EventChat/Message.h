//
//  Message.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Message : NSObject {
    NSInteger mId;
    User *mAuthor;
    NSString *mBody;
    NSString *mCreatedAt;
}

@property (nonatomic, readwrite) NSInteger mId;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mCreatedAt;

@end
