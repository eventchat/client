//
//  Comment.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "ModelProtocol.h"

@interface Comment : NSObject <ModelProtocol> {
    NSString *mId;
    User *mAuthor;
    NSString *mBody;
    NSString *mCreatedAt;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) User *mAuthor;
@property (nonatomic, readwrite) NSString *mBody;
@property (nonatomic, readwrite) NSString *mCreatedAt;

- (id) initWithId: (NSString *) userId withAuthor:(User *) author withBody:(NSString *)body withCreatedAt:(NSString *)createdAt;
@end
