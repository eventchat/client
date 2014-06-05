//
//  FeedsTableViewController.h
//  EventChat
//
//  Created by Lyman Cao on 6/4/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsTableViewController : UITableViewController

@property NSMutableArray *allFeeds;

// called when a new feed is created
- (IBAction)unwindToFeed:(UIStoryboardSegue *)segue;

@end
