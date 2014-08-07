//
//  AttendeeListViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "AttendeeListViewController.h"
#import "AttendeeCell.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "ApiUtil.h"

@interface AttendeeListViewController ()

@end

NSMutableArray *mData;
NSMutableArray *mAttendeeList;

@implementation AttendeeListViewController
@synthesize mEvent;

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
    
    NSDictionary *attendee1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"name", nil, @"avatar_url", nil];
    NSDictionary *attendee2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"name", nil, @"avatar_url", nil];
    mData = [[NSMutableArray alloc] initWithObjects:attendee1, attendee2, nil];
    
    NSLog(@"the passed in event is :%@", mEvent);

    mAttendeeList = [[NSMutableArray alloc] init];
    
    // api request
    NSURLRequest *request = [NSURLRequest requestWithMethod:@"GET" url: [NSString stringWithFormat: JOIN_EVENT, mEvent.mId] parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *attendeeListDataArray = (NSArray *)responseObject;
        for (NSDictionary *attendeeDataDict in attendeeListDataArray) {
        
            User *attendee = [[User alloc] initWithId:[attendeeDataDict objectForKey:@"id"] withEmail:[attendeeDataDict objectForKey:@"email"] withInfo:[attendeeDataDict objectForKey:@"info"] withName:[attendeeDataDict objectForKey:@"name"] withAvatarUrl:[attendeeDataDict objectForKey:@"avatar_url"]];
        
        
            [mAttendeeList addObject:attendee];
            NSLog(@"successfully get attendee: %@", attendee);
        }
        [self.tableView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP request error: %@", error);
    }];
        
        
    [operation start];

    
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
    return [mAttendeeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AttendeeCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    AttendeeCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63.0f;
}

- (void) configureCell: (AttendeeCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    User *attendee = [mAttendeeList objectAtIndex:indexPath.row];
    cell.mNameLabel.text = attendee.mName;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
