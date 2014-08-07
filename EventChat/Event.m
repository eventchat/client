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
@synthesize mAttendees = _mAttendees;

- (NSDictionary *) toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    result[@"name"] = _mName;
    result[@"longitude"] = _mLongitude;
    result[@"latitude"] = _mLatitude;
    result[@"address"] = _mLocation;
    result[@"start_time"] = _mStartTime;
    result[@"end_time"] = _mEndTime;
    result[@"description"] = _mDesc;
    return [result copy];
}

+ (instancetype) eventWithId: (NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees {
    return [[Event alloc] initWithId:eventId eventName:name eventLocation:location eventLongitude:longitude eventLatitude:latitude eventStartTime:startTime eventEndTime:endTime eventDescription:desc eventImageLink:eventImageLink eventAttendees:mAttendees];
}

- (instancetype) initWithId:(NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees{
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
        _mAttendees = [mAttendees copy];
    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"<Event: {mId: %@\n mName: %@\n mLocation: %@\n mLongitude: %@\n mLatitude: %@}>", mId, mName, mLocation, mLongitude, _mLatitude];
}


@end
