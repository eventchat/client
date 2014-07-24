//
//  Event.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize mId = _mId;
@synthesize mName = _mName;
@synthesize mLocation = _mLocation;
@synthesize mLongitude = _mLongitude;
@synthesize mLatitude = _mLatitude;
@synthesize mStartTime = _mStartTime;
@synthesize mEndTime = _mEndTime;
@synthesize mDesc = _mDesc;
@synthesize mEventImageLink = _mEventImageLink;

- (NSDictionary *) toDictionary {
    return nil;
}

+ (instancetype) eventWithId: (NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(double)longitude eventLatitude:(double)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink {
    return [[Event alloc] initWithId:eventId eventName:name eventLocation:location eventLongitude:longitude eventLatitude:latitude eventStartTime:startTime eventEndTime:endTime eventDescription:desc eventImageLink:eventImageLink];
}

- (instancetype) initWithId:(NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(double)longitude eventLatitude:(double)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink {
    self = [super init];
    if (self) {
        _mId = eventId;
        _mName = name;
        _mLocation = location;
        _mLongitude = longitude;
        _mLatitude = latitude;
        _mStartTime = startTime;
        _mEndTime = endTime;
        _mDesc = desc;
        _mEventImageLink = eventImageLink;
    }
    return self;
}

@end
