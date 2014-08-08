//
//  UserProfileViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"

@interface UserProfileViewController : UITableViewController
@property User *mUser;
@property NSMutableArray *mUserPostArray;
@end
