//
//  MeProfileViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 8/6/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MeProfileViewController : UITableViewController
@property AppDelegate *mAppDelegate;
@property User *mAppUser;
@property NSMutableArray *mUserPostArray;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *meInfoLabel;
@end
