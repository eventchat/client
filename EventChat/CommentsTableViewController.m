//
//  CommentsTableViewController.m
//  EventChat
//
//  Created by Lyman Cao on 6/13/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CreateCommentViewController.h"
#import "Comment.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "ApiUtil.h"
#import "ConversationCell.h"

@interface CommentsTableViewController ()

@end

static double const ROW_HEIGHT = 75.0;

@implementation CommentsTableViewController

@synthesize allComments;
@synthesize commentsTableView;
@synthesize currentPost;
@synthesize mId;

// called when a new comment is created
- (IBAction)unwindToComments:(UIStoryboardSegue *)segue;
{
    
    CreateCommentViewController *source = [segue sourceViewController];
    Comment *item = source.toCreateComment;
    if (item) {
        NSLog(@"%@ created!", item.mBody);
        [self sendComment:item];
        
    }else{
        NSLog(@"Comment is nil");
    }
}
- (void)sendComment:(Comment *)toCreateComment{
    NSString *commentUrl = [NSString stringWithFormat:CREATE_COMMENT_TO_POST, currentPost.mId];
    NSURLRequest *commentRequest = [NSURLRequest requestWithMethod:@"POST" url:commentUrl parameters:@{@"body":toCreateComment.mBody}];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:commentRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // update
        currentPost = [Post createPostWithData:responseObject];
        allComments = currentPost.mComments;
        
        [self.commentsTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"create comment error %@",error);
    }];
    [operation start];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [allComments count];
}


- (ConversationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell cellForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (ConversationCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comment *commentItem = [allComments objectAtIndex:indexPath.row];
    cell.nameLabel.text = commentItem.mAuthor.mName;
    
    
    NSDateFormatter *dateFormat = [ApiUtil setDateFormatter:@"yyyy'-'MM'-'dd HH':'mm"];
    
    NSDate *eventDate = [ApiUtil dateFromISO8601String:commentItem.mCreatedAt];
    cell.timeLabel.text = [dateFormat stringFromDate:eventDate];
    
    cell.previewLabel.text = commentItem.mBody;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_HEIGHT;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
