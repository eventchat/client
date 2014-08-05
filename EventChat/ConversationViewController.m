//
//  ChatSelectViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ConversationViewController.h"
#import "ChatMessageViewController.h"
#import "ConversationCell.h"
#import "Conversation.h"
#import "User.h"

@interface ConversationViewController ()
@property NSMutableArray *chatters;
@end

NSDictionary *testData;
NSArray *timelyOrderedConversationArray;

@implementation ConversationViewController
@synthesize appDelegate;
@synthesize appData;
@synthesize conversationDict;
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
    
    // Initialize
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.mData;
    conversationDict = [appData getConversationsDict];
    timelyOrderedConversationArray = [conversationDict allKeys];
    
    self.chatters = [[NSMutableArray alloc] initWithObjects:@"Michael", @"Jason", @"Rose", nil];
    
    testData = [[NSDictionary alloc] init];
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
    NSLog(@"conversationDict is %@", conversationDict);
    NSLog(@"%lu", (unsigned long)[conversationDict count]);
    return [conversationDict count];
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
    [self configureCell:cell cellForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (ConversationCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [timelyOrderedConversationArray objectAtIndex:indexPath.row];
    Conversation *conversation = [conversationDict objectForKey:key];
    User *responder = conversation.mResponder;
    NSLog(@"responder is %@", responder);
    cell.nameLabel.text = responder.mName;
    cell.timeLabel.text = [conversation getMostRecentMessageTime];
    cell.previewLabel.text = [conversation getMostRecentMessageBody];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChatMessage"]) {
        NSIndexPath *indexPath = [self.chatterTable indexPathForSelectedRow];
        NSLog(@"%ld", (long)indexPath.row);
        ChatMessageViewController *destViewController = segue.destinationViewController;

        // update the title of destination view controller to be chatter's name
        NSString *key = [timelyOrderedConversationArray objectAtIndex:indexPath.row];
        destViewController.mConversation = [conversationDict objectForKey:key];
        destViewController.mAppUser = appData.mUser;
        destViewController.navigationItem.title = destViewController.mConversation.mResponder.mName;
        
        // hide the bottom bar
        destViewController.hidesBottomBarWhenPushed = YES;
//        NSLog(@"segue completed!");
    }
}

-(void)reloadData {
    
}


@end
