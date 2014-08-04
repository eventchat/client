//
//  ChatSelectViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ConversationViewController.h"
//#import "ChatterCell.h"
#import "ChatMessageViewController.h"
#import "ConversationCell.h"

@interface ConversationViewController ()
@property NSMutableArray *chatters;
@end

NSDictionary *data;

@implementation ConversationViewController

@synthesize chatterTable = _chatterTable;

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
    
    self.chatters = [[NSMutableArray alloc] initWithObjects:@"Michael", @"Jason", @"Rose", nil];
    
    data = [[NSDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatters count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    return [region name];
//}

- (ConversationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"try to load the chatter cell");
    static NSString *MyIdentifier = @"ConversationCell";
    
    ConversationCell *cell;
    
    NSLog(@"%@", MyIdentifier);
//    if (cell == nil) {
//        cell = [[ConversationCell alloc] init]; // or your custom initialization
//        
//    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//        NSLog(@"description = %@",[cell description]);
    // configure cell
//    [self configureCell:cell cellForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (ConversationCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell isKindOfClass:[ConversationCell class]]) {
//        NSLog(@"check ConversationCell");
//    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChatMessage"]) {
        NSIndexPath *indexPath = [self.chatterTable indexPathForSelectedRow];
        NSLog(@"%ld", (long)indexPath.row);
        ChatMessageViewController *destViewController = segue.destinationViewController;

        // update the title of destination view controller to be chatter's name
        destViewController.navigationItem.title = [self.chatters objectAtIndex:indexPath.row];
        
        // hide the bottom bar
        destViewController.hidesBottomBarWhenPushed = YES;
//        NSLog(@"segue completed!");
    }
}

-(void)reloadData {
    
}


@end
