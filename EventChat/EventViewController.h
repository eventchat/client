//
//  EventViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *postsTableView;

@property NSArray *mPosts;
@property Event *mEvent;
@end
