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
@end

NSDictionary *testData;
NSArray *timelyOrderedConversationArray;

@implementation ConversationViewController
@synthesize mAppDelegate;
@synthesize mAppData;
@synthesize mConversationDict;
@synthesize mConversationTable = _mConversationTable;

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
    NSLog(@"conversation view controller is loaded");
    
    // Initialize
    mAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mAppData = mAppDelegate.mData;
    mConversationDict = [mAppData getConversationsDict];
    timelyOrderedConversationArray = [mConversationDict allKeys];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadConversationData:) name:@"NewMessageNotification" object:nil];
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
    NSLog(@"conversationDict is %@", mConversationDict);
    NSLog(@"%lu", (unsigned long)[mConversationDict count]);
    return [mConversationDict count];
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
    Conversation *conversation = [mConversationDict objectForKey:key];
    User *responder = conversation.mResponder;
    NSLog(@"responder is %@", responder);
    cell.nameLabel.text = responder.mName;
    cell.timeLabel.text = [conversation getMostRecentMessageTime];
    cell.previewLabel.text = [conversation getMostRecentMessageBody];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    NSURL *imageURL = [NSURL URLWithString:responder.mAvatarUrl];
    
    if (imageURL != (id)[NSNull null]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                UIImage *newImage = [UIImage imageWithData:imageData];
                if (newImage) {
                    cell.avatarImageView.image = newImage;
                }
                
            });
        });
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChatMessage"]) {
        NSIndexPath *indexPath = [self.mConversationTable indexPathForSelectedRow];
        NSLog(@"%ld", (long)indexPath.row);
        ChatMessageViewController *destViewController = segue.destinationViewController;

        // update the title of destination view controller to be chatter's name
        NSString *key = [timelyOrderedConversationArray objectAtIndex:indexPath.row];
        destViewController.mConversation = [mConversationDict objectForKey:key];
        destViewController.mAppUser = mAppData.mUser;
        NSLog(@" the current user is %@", mAppData.mUser);
        NSLog(@"the current responder is %@", destViewController.mConversation.mResponder);
        destViewController.navigationItem.title = destViewController.mConversation.mResponder.mName;
        
        // hide the bottom bar
        destViewController.hidesBottomBarWhenPushed = YES;
//        NSLog(@"segue completed!");
    }
}


#pragma mark
-(void)reloadConversationData:(NSNotification *) notif {
    timelyOrderedConversationArray = [mConversationDict allKeys];
    [self.mConversationTable reloadData];
}

@end
