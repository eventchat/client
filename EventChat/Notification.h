//
//  Notification.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

@interface Notification : NSObject <ModelProtocol> {
    NSString *mId;
    NSString *mType;
    NSString *mBody;
    BOOL mIsRead;
    NSString *mCreatedAt;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mType;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) BOOL mIsRead;
@property (nonatomic, readwrite) NSString *mCreatedAt;

@end
