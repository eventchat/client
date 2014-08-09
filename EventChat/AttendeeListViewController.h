//
//  AttendeeListViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "ECData.h"

@interface AttendeeListViewController : UITableViewController
@property Event* mEvent;
@property User *mAppUser;
@property ECData *mAppData;
@end
