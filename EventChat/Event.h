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
    NSNumber *mLongitude;
    NSNumber *mLatitude;
    NSString *mStartTime;
    NSString *mEndTime;
    NSString *mDesc;
    NSString *mEventImageLink;
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
@property NSMutableArray *mAttendees;

+(instancetype) eventWithId: (NSString *)mId eventName:(NSString *)mName eventLocation:(NSString *)mLocation eventLongitude:(NSNumber *)mLongitude eventLatitude:(NSNumber *)mLatitude eventStartTime:(NSString *)mStartTime eventEndTime:(NSString *)mEndTime eventDescription:(NSString *)mDesc eventImageLink:(NSString *)mEventImageLink eventAttendees:(NSArray *)mAttendees;
    
-(instancetype) initWithId: (NSString *)mId eventName:(NSString *)mName eventLocation:(NSString *)mLocation eventLongitude:(NSNumber *)mLongitude eventLatitude:(NSNumber *)mLatitude eventStartTime:(NSString *)mStartTime eventEndTime:(NSString *)mEndTime eventDescription:(NSString *)mDesc eventImageLink:(NSString *)mEventImageLink eventAttendees:(NSArray *)mAttendees;

@end
