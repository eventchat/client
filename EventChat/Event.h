//
//  Event.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject {
    NSInteger mId;
    NSString *mName;
    double mLongitude;
    double mLatitude;
    NSString *mStartTime;
    NSString *mEndTime;
    NSString *mDesc;
}

@property (nonatomic, readwrite) NSInteger mId;
@property (nonatomic, readwrite) double mLongitude;
@property (nonatomic, readwrite) double mLatitude;
@property (nonatomic, readwrite) NSString *mStartTime;
@property (nonatomic, readwrite) NSString *mEndTime;
@property (nonatomic, readwrite) NSString *mDesc;

@end
