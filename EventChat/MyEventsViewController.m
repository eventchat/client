//
//  MyEventsViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/23/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "MyEventsViewController.h"
#import "EventCell.h"

static NSString * const  EventCellIdentifier = @"EventCell";

@interface MyEventsViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MyEventsViewController

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
	// Do any additional setup after loading the view.
    NSDictionary *event1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"The Foodies Restaurant Exploring Trip", @"EventName", @"Sept. 31, 2014", @"EventTime", @"Attended", @"EventRole", nil];
    NSDictionary *event2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"The Random Photography Meetup", @"EventName", @"Oct. 12, 2014", @"EventTime", @"Attended", @"EventRole", nil];
    NSDictionary *event3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Academic Conference", @"EventName", @"Oct. 18, 2014", @"EventTime", @"Attended", @"EventRole", nil];
    
    
    self.data = [[NSMutableArray alloc] init];
    [self.data addObject:event1];
    [self.data addObject:event2];
    [self.data addObject:event3];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = [self.eventsTableView dequeueReusableCellWithIdentifier:EventCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void) configureCell: (EventCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellData = [self.data objectAtIndex:indexPath.row];
    cell.eventTitleLabel.text = [cellData valueForKey:@"EventName"];
    cell.eventTimeLabel.text = [cellData valueForKey:@"EventTime"];
}

@end
