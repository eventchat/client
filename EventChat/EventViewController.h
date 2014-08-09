//
//  EventViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "PostBasicCell.h"


@interface EventViewController : UITableViewController <PostCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *postsTableView;
- (IBAction)unwindToEventPosts:(UIStoryboardSegue *)segue;

@property NSMutableArray *mPosts;
@property Event *mEvent;


- (void)commentLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)likeLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
