//
//  CommentsTableViewController.h
//  EventChat
//
//  Created by Lyman Cao on 6/13/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "User.h"

@interface CommentsTableViewController : UITableViewController

@property NSMutableArray *allComments;
@property Post *currentPost;
@property User *currentUser;
@property NSString *mId;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;

- (IBAction)unwindToComments:(UIStoryboardSegue *)segue;

@end
