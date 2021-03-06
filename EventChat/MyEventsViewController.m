//
//  MyEventsViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/23/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "MyEventsViewController.h"
#import "EventCell.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "ECData.h"
#import "AppDelegate.h"
#import "ApiUtil.h"
#import "EventViewController.h"

static NSString * const  EventCellIdentifier = @"EventCell";

@interface MyEventsViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MyEventsViewController{
    AppDelegate *appDelegate;
    ECData *appData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.mData;
    
	// update all the events
    [self updateAllEvents];
    
    
}

- (void)updateAllEvents {
    NSURLRequest *allEventsRequest = [NSURLRequest requestWithMethod:@"GET" url:[NSString stringWithFormat: GET_ALL_EVENTS_A_USER_ATTENDS, appData.mId] parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:allEventsRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allEvents = (NSArray *)responseObject;
        
        // empty all the events first
        [appData clearAllEvents];
        
        for (NSDictionary *eDict in allEvents) {
            Event *singleEvent = [Event createEventwithDictionary:eDict];
            [appData.mEvents addObject:singleEvent];
        }

        [self.eventsTableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get all events info. id: %@. Error %@",appData.mId ,error);
    }];
    [operation start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appData.mEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = [self.eventsTableView dequeueReusableCellWithIdentifier:EventCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void) configureCell: (EventCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Event *cellData = [appData.mEvents objectAtIndex:indexPath.row];
    cell.eventTitleLabel.text = cellData.mName;
    
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    
    NSDate *eventDate = [ApiUtil dateFromISO8601String:cellData.mStartTime];
    cell.eventTimeLabel.text = [dateFormat stringFromDate:eventDate];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSingleEvent"]) {
        NSIndexPath *indexPath = [self.eventsTableView indexPathForSelectedRow];
        NSLog(@"%ld", (long)indexPath.row);
        EventViewController *destViewController = segue.destinationViewController;
        
        // update the title of destination view controller to be chatter's name
        destViewController.mEvent = [appData.mEvents objectAtIndex:indexPath.row];
        
        // hide the bottom bar
//        destViewController.hidesBottomBarWhenPushed = YES;
        NSLog(@"single event segue completed!");
    }
}


@end
