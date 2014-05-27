//
//  User.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSInteger mId;
    NSString *mName;
    NSString *mEmail;
    NSString *mInfo;
    NSString *mAvatarUrl;
}

@property (nonatomic, readwrite) NSInteger mId;
@property (nonatomic, readwrite) NSString *mName;
@property (nonatomic, readwrite) NSString *mEmail;
@property (nonatomic, readwrite) NSString *mInfo;
@property (nonatomic, readwrite) NSString *mAvatarUrl;

@end
