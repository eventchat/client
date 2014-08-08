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
@synthesize mOrganizer = _mOrganizer;

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

+ (instancetype) createEventwithDictionary: (NSDictionary *) eventData {
    NSArray *attendeeListData = [eventData objectForKey:@"attendees"];
    NSMutableArray *attendeeList = [[NSMutableArray alloc] init];
    
    // incase api for event is not implemented with attendees
    if (attendeeListData) {
        for (NSDictionary *attendeeData in attendeeListData) {
            [attendeeList addObject:[User createUserWithDictionary:attendeeData]];
        }
        
    }
    
    return [[Event alloc] initWithId:[eventData objectForKey:@"id"] eventName:[eventData objectForKey:@"name"] eventLocation:[eventData objectForKey:@"address"] eventLongitude:[eventData objectForKey:@"longitude"] eventLatitude:[eventData objectForKey:@"latitude"] eventStartTime:[eventData objectForKey:@"start_time"] eventEndTime:[eventData objectForKey:@"end_time"] eventDescription:[eventData objectForKey:@"description"] eventImageLink:nil eventAttendees:attendeeList eventOrganizer:[User createUserWithDictionary:[eventData objectForKey:@"organizer"]]];
}

+ (instancetype) createEventWithId: (NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees eventOrganizer: (User *)organizer {
    return [[Event alloc] initWithId:eventId eventName:name eventLocation:location eventLongitude:longitude eventLatitude:latitude eventStartTime:startTime eventEndTime:endTime eventDescription:desc eventImageLink:eventImageLink eventAttendees:mAttendees eventOrganizer:organizer];
}

- (instancetype) initWithId:(NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees eventOrganizer: (User *)organizer {
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
        _mOrganizer = [organizer copy];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Event: {mId: %@\n mName: %@\n mLocation: %@\n _mLongitude: %@\n _mLatitude: %@\n _mStartTime: %@\n _mEndTime: %@\n _mDesc: %@\n _mOrganizer: %@\n number of attendees: %lu}>", _mId, _mName, _mLocation, _mLongitude, _mLatitude, _mStartTime, _mEndTime, _mDesc, _mOrganizer, (unsigned long)[_mAttendees count]];
}

@end
