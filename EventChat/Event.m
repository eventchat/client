//
//  Event.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize mId;
@synthesize mName;
@synthesize mLocation;
@synthesize mLongitude;
@synthesize mLatitude;
@synthesize mStartTime;
@synthesize mEndTime;
@synthesize mDesc;
@synthesize mEventImageLink;

- (NSDictionary *) toDictionary {
    return nil;
}

@end
