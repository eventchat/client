//
//  MeProfileViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 8/6/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "MeProfileViewController.h"
#import "ApiUtil.h"
#import "PostBasicCell.h"
#import "PostImageCell.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "ChatMessageViewController.h"
#import "CommentsTableViewController.h"

static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";

@interface MeProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userAvatar;

@end

NSMutableArray *mData;

@implementation MeProfileViewController
@synthesize mAppDelegate;
@synthesize mAppUser;
@synthesize mUserPostArray;


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
    
    
    // initialization
    mAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mAppUser = mAppDelegate.mData.mUser;
    mUserPostArray = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIColor *color = [ApiUtil colorWithHexString:@"FDA10F"];
    self.view.backgroundColor = color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // status bar style
    [self setNeedsStatusBarAppearanceUpdate];
    
    // set user profile info and name
    [self updateUserPosts];
    [self updateUserProfile];

}

- (void)updateUserPosts{
    // update posts requeset
    NSURLRequest *allPostsRequest = [NSURLRequest requestWithMethod:HTTP_GET url: [NSString stringWithFormat: GET_POST_BY_USER_ID, mAppUser.mId] parameters:nil];
    AFHTTPRequestOperation *allPostsOperation = [[AFHTTPRequestOperation alloc] initWithRequest:allPostsRequest];
    allPostsOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [allPostsOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the response is %@", responseObject);
        NSArray *postListArray = (NSArray *)responseObject;
        for (NSDictionary *postData in postListArray) {
            Post *receivedPost = [Post createPostWithData:postData];
            NSLog(@"successfully get post: %@", receivedPost);
            [mUserPostArray addObject:receivedPost];
            
        }
        [self.tableView reloadData];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP request error: %@", error);
    }];
    
    
    [allPostsOperation start];
}

-(void)updateUserProfile{
    // update profile requeset
    NSURLRequest *profileRequest = [NSURLRequest requestWithMethod:HTTP_GET url: [NSString stringWithFormat: GET_USER , mAppUser.mId] parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:profileRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *userDataDict = (NSDictionary *)responseObject;
        
        User *meUser = [User createUserWithDictionary:userDataDict];
        mAppDelegate.mData.mUser = meUser;
        
        [self modifyUserProfile];
        [self.tableView reloadData];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP request error: %@", error);
    }];
    
    [operation start];
}

- (void)modifyUserProfile{
    self.userNameLabel.text = mAppUser.mName != (id)[NSNull null] ? mAppUser.mName:@"";
    self.userInfoLabel.text = mAppUser.mInfo != (id)[NSNull null] ? mAppUser.mInfo:@"";
    
    NSURL *imageURL = [NSURL URLWithString:mAppUser.mAvatarUrl];
    if (imageURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                UIImage *newImage = [UIImage imageWithData:imageData];
                if (newImage) {
                    self.userAvatar.image = newImage;
                }
                
            });
        });
    }
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//
//    // Configure the cell...
//
//    return cell;
//}

#pragma mark - setting status bar style
-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self imageCellAtIndexPath:indexPath];
    } else {
        NSLog(@"the index path for cell is :%ld", (long)indexPath.row);
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
    
    NSURL *imageURL = [NSURL URLWithString:[ApiUtil detectUrlInString:currentPost.mAuthor.mAvatarUrl]];
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

- (void)configureImageCell:(PostImageCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    [self configureBasicCell:cell forIndexPath:indexPath];
    
    Post *currentPost = [mUserPostArray objectAtIndex:indexPath.row];
    cell.messageImageView.image = [UIImage imageNamed:@"food"];
    
    NSURL *imageURL = [NSURL URLWithString:[ApiUtil detectUrlInString:currentPost.mBody]];
    if (imageURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                UIImage *newImage = [UIImage imageWithData:imageData];
                if (newImage) {
                    cell.messageImageView.image = newImage;
                }
                
            });
        });
    }else{
        // default image
        cell.messageImageView.image = [UIImage imageNamed:@"food"];
    }
    
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    Post *currentPost = [mUserPostArray objectAtIndex:indexPath.row];
    return ![currentPost.mType isEqualToString:@"text"];
}

- (PostBasicCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    PostBasicCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PostBasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostBasicCellIdentifier];
        
        cell.backgroundColor = self.tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        cell.dataSource = self.mUserPostTableView;
        //        cell.delegate = self.mUserPostTableView;
    }
    [self configureBasicCell:cell forIndexPath:indexPath];
    return cell;
}

- (PostImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PostImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostImageCellIdentifier];
        
        cell.backgroundColor = self.tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */
#pragma mark - PostBasicCellDelegate methods
- (void)commentLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Post *currentPost = [mData objectAtIndex:indexPath.row];
    
    UIStoryboard *commentStoryboard = [UIStoryboard storyboardWithName:@"Comments" bundle:nil];
    CommentsTableViewController *commentsViewController = [commentStoryboard instantiateViewControllerWithIdentifier:@"myComments"];
    commentsViewController.allComments = currentPost.mComments;
    commentsViewController.currentPost = currentPost;
    commentsViewController.currentUser = mAppDelegate.mData.mUser;
    
    [(UINavigationController *)self.parentViewController pushViewController: commentsViewController animated:YES];
    // because the navigation controller for comments is needed
    
}
- (void)likeLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath  likeStatus:(BOOL)liked{
    Post *currentPost = [mData objectAtIndex:indexPath.row];
    NSString *likeUrl = [NSString stringWithFormat:LIKE_POST, currentPost.mId];
    NSURLRequest *likeRequest;
    if (liked) {
        likeRequest = [NSURLRequest requestWithMethod:@"DELETE" url:likeUrl parameters:nil];
    }else{
        likeRequest = [NSURLRequest requestWithMethod:@"POST" url:likeUrl parameters:nil];
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:likeRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"like succeed!");
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"like error %@",error);
    }];
    [operation start];
}



@end
