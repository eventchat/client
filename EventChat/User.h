//
//  User.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

@interface User : NSObject <ModelProtocol> {
    NSString *mId;
    NSString *mName;
    NSString *mEmail;
    NSString *mInfo;
    NSString *mAvatarUrl;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mName;
@property (nonatomic, readwrite) NSString *mEmail;
@property (nonatomic, readwrite) NSString *mInfo;
@property (nonatomic, readwrite) NSString *mAvatarUrl;

- (id) initWithId: (NSString *) userId withEmail: (NSString *) email withInfo: (NSString *) info withName: (NSString *)name withAvatarUrl: (NSString *) avatarUrl;

@end
