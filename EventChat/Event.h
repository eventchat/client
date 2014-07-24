//
//  Event.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

@interface Event : NSObject <ModelProtocol> {
    NSString *mId;
    NSString *mName;
    NSString *mLocation;
    double mLongitude;
    double mLatitude;
    NSString *mStartTime;
    NSString *mEndTime;
    NSString *mDesc;
    NSString *mEventImageLink;
}

@property (nonatomic, readwrite) NSString *mId;
@property (nonatomic, readwrite) NSString *mName;
@property (nonatomic, readwrite) NSString *mLocation;
@property (nonatomic, readwrite) double mLongitude;
@property (nonatomic, readwrite) double mLatitude;
@property (nonatomic, readwrite) NSString *mStartTime;
@property (nonatomic, readwrite) NSString *mEndTime;
@property (nonatomic, readwrite) NSString *mDesc;
@property (nonatomic, readwrite) NSString *mEventImageLink;

@end
