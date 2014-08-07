//
//  Event.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "User.h"

@interface Event : NSObject <ModelProtocol> {
    NSString *mId;
    NSString *mName;
    NSString *mLocation;
    NSNumber *mLongitude;
    NSNumber *mLatitude;
    NSString *mStartTime;
    NSString *mEndTime;
    NSString *mDesc;
    NSString *mEventImageLink;
    User *mOrganizer;
}


@property (nonatomic, copy) NSString *mId;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mLocation;
@property (nonatomic, readwrite) NSNumber * mLongitude;
@property (nonatomic, readwrite) NSNumber * mLatitude;
@property (nonatomic, copy) NSString *mStartTime;
@property (nonatomic, copy) NSString *mEndTime;
@property (nonatomic, copy) NSString *mDesc;
@property (nonatomic, copy) NSString *mEventImageLink;
@property (nonatomic, copy) User *mOrganizer;
@property NSMutableArray *mAttendees;

+ (instancetype) eventWithId: (NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees eventOrganizer: (User *)organizer;
    
- (instancetype) initWithId:(NSString *)eventId eventName:(NSString *)name eventLocation:(NSString *)location eventLongitude:(NSNumber *)longitude eventLatitude:(NSNumber *)latitude eventStartTime:(NSString *)startTime eventEndTime:(NSString *)endTime eventDescription:(NSString *)desc eventImageLink:(NSString *)eventImageLink eventAttendees:(NSArray *)mAttendees eventOrganizer: (User *)organizer;

@end
