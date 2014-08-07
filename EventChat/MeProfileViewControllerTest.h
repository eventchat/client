//
//  ProfileViewController.h
//  EventChat
//
//  Created by Lyman Cao on 7/11/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MeProfileViewControllerTest : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mUserPostTableView;
@property AppDelegate *mAppDelegate;
@property ECData *mAppData;

@end
