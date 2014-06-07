//
//  FeedsTableViewController.m
//  EventChat
//
//  Created by Lyman Cao on 6/4/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "FeedsTableViewController.h"
#import "JsonParser.h"
#import "Constants.h"
#import "Post.h"
#import "User.h"
#import "ItemCell.h"

@interface FeedsTableViewController ()

@end

@implementation FeedsTableViewController


// called when a new feed is created
- (IBAction)unwindToFeed:(UIStoryboardSegue *)segue;
{
    
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

    self.allFeeds = [[NSMutableArray alloc] init];
    [self loadInitData];
    
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
    NSLog(@"%d", [self.allFeeds count]);
    return [self.allFeeds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Dequeue Cell
    static NSString *CellIdentifier = @"ContentCell";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Post *post = [self.allFeeds objectAtIndex: indexPath.row];
    cell.userName.text = post.mTitle;
    cell.msgText.text = post.mBody;
    cell.msgTime.text = post.mCreatedAt;
//    cell.msgLocation = nil;
    cell.msgLocation.text = @"Convention Center";
    cell.userImage.image = [UIImage imageNamed:@"placeholder"];
    cell.msgImage.image = [UIImage imageNamed:@"testImage"];
    
    return cell;
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


- (void) loadInitData {
    
    JsonParser *parser = [[JsonParser alloc] init];
//    NSDictionary *dict = [parser parse:[NSURL URLWithString:@"http://eventchat.herokuapp.com/users/538797bb940bf30200bdb649"]];
//    NSString *name = [dict valueForKey:@"name"];
//    NSString *body = dict[@"body"];
    
    
    // mock up data
    User *testUser = [[User alloc] init];
    testUser.mName = @"Lyman Cao";
    testUser.mId = @"538797bb940bf30200bdb649";
    testUser.mEmail = @"lyman@cmu.edu";
    
    Post *testPost = [[Post alloc] init];
    
    testPost.mId = @"818797bb940bf30200bdb649";
    testPost.mTitle = @"hello world";
    testPost.mBody = @"my first post";
    testPost.mAuthor = testUser;
    
    // add the test post
    [self.allFeeds addObject:testPost];
    
//    NSLog(@"%@", name);
//    NSLog(@"%@", body);
}

@end
