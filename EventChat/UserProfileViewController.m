//
//  UserProfileViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "UserProfileViewController.h"
#import "ApiUtil.h"
#import "PostBasicCell.h"
#import "PostImageCell.h"
#import "AFNetworking.h"
#import "ChatMessageViewController.h"

static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mChatButton;

@end

NSMutableArray *mData;

@implementation UserProfileViewController
@synthesize mUser;
@synthesize mUserPostArray;
@synthesize mAppUser;
@synthesize mAppData;
@synthesize nameLabel;
@synthesize userInfoLabel;

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

    UIColor *color = [ApiUtil colorWithHexString:@"FDA10F"];
    self.view.backgroundColor = color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // status bar style
    [self setNeedsStatusBarAppearanceUpdate];
    
//    NSDictionary *data1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Jason Tao", @"author", @"avatar link", @"avatar", @"9:33pm, June 10, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"This meetup is awesome! So many interesting people here. Learnt a lot from them!", @"message", nil];
//    
//    NSDictionary *data2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"author", @"avatar link", @"avatar", @"00:13pm, June 09, 2014", @"time", @"3", @"likeCnt", @"2", @"commentCnt", @"blahblahblah blahblahblah, la la la", @"message", @"random link to an image", @"image", nil];
//    
//    NSDictionary *data3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"author", @"avatar link", @"avatar", @"02:00am, June 05, 2014", @"time", @"8", @"likeCnt", @"7", @"commentCnt", @"what is the result for this test?", @"message", @"random image link", @"image", nil];
//    
//    mData = [[NSMutableArray alloc] init];
//    [mData addObject:data1];
//    [mData addObject:data2];
//    [mData addObject:data3];

    // button observer registration
//    [self.mChatButton addTarget:self action:@selector(chatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // initialization
    NSLog(@"The passed in user is %@", mUser);
    mUserPostArray = [[NSMutableArray alloc] init];
    
    nameLabel.text = mUser.mName;
    userInfoLabel.text = mUser.mInfo;
    
    // api requeset
    NSURLRequest *request = [NSURLRequest requestWithMethod:HTTP_GET url: [NSString stringWithFormat: GET_POST_BY_USER_ID, mUser.mId] parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the response is %@", responseObject);
        NSArray *postListArray = (NSArray *)responseObject;
        for (NSDictionary *postData in postListArray) {
            //            User *author = [[User alloc] initWithId:[authorData objectForKey:@"id"] withEmail:[authorData objectForKey:@"email"] withInfo:[authorData objectForKey:@"info"] withName:[authorData objectForKey:@"name"] withAvatarUrl:[authorData objectForKey:@"avatar_url"] withCreatedAt:[authorData objectForKey:@"created_at"]];
            //
            //            Post *userPost = [[Post alloc] initWithId:[postData objectForKey:@"id"] withTitle:[postData objectForKey:@"title"] withAuthor:[postData objectForKey:@"author"] withBody:[postData objectForKey:@"body"] withPic:Nil withCreatedAt:[postData objectForKey:@"created_at"] withComments:[postData objectForKey:@"comments"] withLikes:[postData objectForKey:@"likes"] withType:[postData objectForKey:@"type"] withEvent:[postData objectForKey:@"event"]];
            
            Post *receivedPost = [Post createPostWithData:postData];
            NSLog(@"successfully get post: %@", receivedPost);
            [mUserPostArray addObject:receivedPost];
            
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
    return [mUserPostArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self imageCellAtIndexPath:indexPath];
    } else {
        return [self basicCellAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self heightForImageCellAtIndexPath:indexPath];
    } else {
        return [self heightForBasicCellAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self hasImageAtIndexPath:indexPath]) {
        return 160.0f;
    } else {
        return 400.0f;
    }
}

#pragma mark - private methods

- (void)deselectAllRows {
    for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)configureBasicCell: (PostBasicCell *)cell forIndexPath: (NSIndexPath *)indexPath {
    // Configure the cell...
    Post *currentPost = [mUserPostArray objectAtIndex:indexPath.row];
    
    cell.authorLabel.text = currentPost.mAuthor.mName;
    
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    NSDate *postDate = [ApiUtil dateFromISO8601String:currentPost.mCreatedAt];
    cell.timeLabel.text = [dateFormat stringFromDate:postDate];
    
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[currentPost.mLikes count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[currentPost.mComments count]];
    
    cell.messageLabel.text = currentPost.mBody;
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
}

- (void)configureImageCell:(PostImageCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    Post *currentPost = [mUserPostArray objectAtIndex:indexPath.row];
    
    cell.authorLabel.text = currentPost.mAuthor.mName;
    
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    NSDate *postDate = [ApiUtil dateFromISO8601String:currentPost.mCreatedAt];
    cell.timeLabel.text = [dateFormat stringFromDate:postDate];
    
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[currentPost.mLikes count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[currentPost.mComments count]];
    
    cell.messageLabel.text = currentPost.mBody;
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    [cell.messageImageView setImage:nil];
    [cell.messageImageView setImage:[UIImage imageNamed:@"food"]];
    
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    Post *currentPost = [mUserPostArray objectAtIndex:indexPath.row];
    return ![currentPost.mType isEqualToString:@"text"];
}

- (PostBasicCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    PostBasicCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell forIndexPath:indexPath];
    return cell;
}

- (PostImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier forIndexPath:indexPath];
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static PostBasicCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier];
    });
    
    [self configureBasicCell:sizingCell forIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell] + 1;
}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath {
    static PostImageCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier];
    });
    
    [self configureImageCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell] + 1;
}

- (CGFloat) calculateHeightForConfiguredSizingCell: (UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
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


#pragma mark - Navigation
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"createNewConversation"]) {
         

         ChatMessageViewController *destViewController = segue.destinationViewController;
 
         // update the title of destination view controller to be chatter's name
         NSLog(@"the current app user is :%@", mAppUser);
         destViewController.mAppUser = mAppUser;
         
         // need to check if the target user has already in the conversation dict
         Conversation *userConversation = [mAppData.mConversationsDict objectForKey:mUser.mId];
         if (userConversation == nil) {
             // if there is no previous conversation with this user
             userConversation = [[Conversation alloc] initWithResponder:mUser];
             [mAppData.mConversationsDict setObject:userConversation forKey:mUser.mId];
             destViewController.mConversation = userConversation;
             NSLog(@"created new conversation");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewMessageNotification" object:Nil];
         } else {
             // there is existing conversation with this user
             destViewController.mConversation = userConversation;
             NSLog(@"forward to existing conversation");
         }
         // update chat window title
         destViewController.navigationItem.title = destViewController.mConversation.mResponder.mName;
         // hide the bottom bar
         destViewController.hidesBottomBarWhenPushed = YES;
     }
}

@end
