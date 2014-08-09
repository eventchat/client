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
@property User *mAppUser;
@property ECData *mAppData;
@property NSMutableArray *mUserPostArray;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;
@end
