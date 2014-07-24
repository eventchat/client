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

@property (nonatomic, copy) NSString *mId;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mLocation;
@property (nonatomic, readwrite) double mLongitude;
@property (nonatomic, readwrite) double mLatitude;
@property (nonatomic, copy) NSString *mStartTime;
@property (nonatomic, copy) NSString *mEndTime;
@property (nonatomic, copy) NSString *mDesc;
@property (nonatomic, copy) NSString *mEventImageLink;

+(instancetype) eventWithId: (NSString *)mId eventName:(NSString *)mName eventLocation:(NSString *)mLocation eventLongitude:(double)mLongitude eventLatitude:(double)mLatitude eventStartTime:(NSString *)mStartTime eventEndTime:(NSString *)mEndTime eventDescription:(NSString *)mDesc eventImageLink:(NSString *)mEventImageLink;
    
-(instancetype) initWithId: (NSString *)mId eventName:(NSString *)mName eventLocation:(NSString *)mLocation eventLongitude:(double)mLongitude eventLatitude:(double)mLatitude eventStartTime:(NSString *)mStartTime eventEndTime:(NSString *)mEndTime eventDescription:(NSString *)mDesc eventImageLink:(NSString *)mEventImageLink;

@end
