//
//  EventViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//
#import "AFNetworking.h"
#import "EventViewController.h"
#import "PostBasicCell.h"
#import "PostImageCell.h"
#import "ECData.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "ApiUtil.h"
#import "CreatePostViewController.h"
#import "AttendeeListViewController.h"


static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";

static int const MAX_DISTANCE = 100;

@interface EventViewController ()
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation EventViewController{
    AppDelegate *appDelegate;
    ECData *appData;
}

@synthesize mEvent;
@synthesize mPosts;

// called when a new comment is created
- (IBAction)unwindToEventPosts:(UIStoryboardSegue *)segue;
{
    CreatePostViewController *source = [segue sourceViewController];
    Post *item = source.toCreatePost;
    if (item != nil) {
        [self.mPosts addObject:item];
        [self.tableView reloadData];
    }else{
        NSLog(@"Post is nil");
    }
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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.mData;
    
    // now update all the posts
    [self updateAllPosts:mEvent.mId];
    
    // now update the event detail
    [self updateEventDetail];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
}

-(void)updateEventDetail{
    _eventTitleLabel.text = mEvent.mName;
    _hostLabel.text = mEvent.mOrganizer.mName;
   
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    NSDate *eventDate = [ApiUtil dateFromISO8601String:mEvent.mStartTime];
    _dateLabel.text = [dateFormat stringFromDate:eventDate];
    _addressLabel.text = mEvent.mLocation;
    _descLabel.text = mEvent.mDesc;
}

- (void)updateAllPosts:(NSString *)eventId{
    NSString *getAllPostsUrl = [NSString stringWithFormat: GET_POSTS_BY_EVENT_ID, eventId];
    NSLog(@"get all posts url: %@", getAllPostsUrl);
    NSURLRequest *allPostsRequest = [NSURLRequest requestWithMethod:@"GET" url:getAllPostsUrl parameters:nil];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:allPostsRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allPostsDict = (NSArray *)responseObject;
        // init mPosts
        mPosts = [[NSMutableArray alloc] init];
        
        for(NSDictionary *singlePostDict in [allPostsDict reverseObjectEnumerator]){

            
            // create post author
            NSDictionary *authorDict = singlePostDict[@"author"];
            User *author = [[User alloc] initWithId:authorDict[@"id"] withEmail:authorDict[@"email"] withInfo:authorDict[@"info"] withName:authorDict[@"name"] withAvatarUrl:authorDict[@"avatar_url"]];
            
            // create post comments
            NSArray *commentsDict = singlePostDict[@"comments"];
            NSMutableArray *comments = [[NSMutableArray alloc] init];
            for (NSDictionary *singleCommentDict in commentsDict) {
                // create the comment author
                NSDictionary *commentAuthorDict = singleCommentDict[@"author"];
                User *commentAuthor = [[User alloc] initWithId:commentAuthorDict[@"id"] withEmail:commentAuthorDict[@"email"] withInfo:commentAuthorDict[@"info"] withName:commentAuthorDict[@"name"] withAvatarUrl:commentAuthorDict[@"avatar_url"]];
                
                // add each comment object
                [comments addObject: [[Comment alloc]initWithId:singleCommentDict[@"id"] withAuthor: commentAuthor withBody:singleCommentDict[@"body"] withCreatedAt:singleCommentDict[@"created_at"]]];
            }
            
            // create post likes
            NSArray *likedByDict = singlePostDict[@"liked_by"];
            NSMutableArray *likedBys = [[NSMutableArray alloc] init];
            for (NSDictionary *singleLikeByDict in likedByDict){
                // create each likeby user
                User *likeByAuthor = [[User alloc] initWithId:singleLikeByDict[@"id"] withEmail:singleLikeByDict[@"email"] withInfo:singleLikeByDict[@"info"] withName:singleLikeByDict[@"name"] withAvatarUrl:singleLikeByDict[@"avatar_url"]];

                // add the new user to the list
                [likedBys addObject:likeByAuthor];
            }
            
            // now add it to mPosts
            [mPosts addObject: [[Post alloc] initWithId:singlePostDict[@"id"] withTitle:singlePostDict[@"title"] withAuthor:author withBody:singlePostDict[@"body"] withPic: [ApiUtil detectUrlInString:singlePostDict[@"body"]] withCreatedAt:singlePostDict[@"created_at"] withComments:comments withLikes:likedBys withType:singlePostDict[@"type"] withEvent:mEvent]];

        }
        
        [self.postsTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get all posts info. id: %@. Error %@",appData.mId ,error);
    }];
    [operation start];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self deselectAllRows];
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
    return [mPosts count];
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
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    
    cell.authorLabel.text = currentPost.mAuthor.mName;
    
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    NSDate *postDate = [ApiUtil dateFromISO8601String:currentPost.mCreatedAt];
    cell.timeLabel.text = [dateFormat stringFromDate:postDate];
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu", [currentPost.mLikes count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu", [currentPost.mComments count]];
    
    cell.messageLabel.text = currentPost.mBody;
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
}

- (void)configureImageCell:(PostImageCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    cell.authorLabel.text = currentPost.mAuthor.mName;
    
    NSDateFormatter *dateFormat = [ApiUtil getDateFormatter];
    NSDate *postDate = [ApiUtil dateFromISO8601String:currentPost.mCreatedAt];
    cell.timeLabel.text = [dateFormat stringFromDate:postDate];
    
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu", [currentPost.mLikes count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu", [currentPost.mComments count]];
    
    cell.messageLabel.text = currentPost.mBody;
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    [cell.messageImageView setImage:[UIImage imageNamed:@"food"]];
    
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
    }
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    return ![currentPost.mType isEqualToString:@"text"];

}

- (PostBasicCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    PostBasicCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier forIndexPath:indexPath];
//    cell.delegate = self.postsTableView;
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEventAttendeeList"]) {
        AttendeeListViewController *destViewController = segue.destinationViewController;
        destViewController.mEvent = self.mEvent;
    }else if([segue.identifier isEqualToString:@"composePost"]){
        
        CreatePostViewController *createPostViewController = (CreatePostViewController *)[[segue destinationViewController] topViewController];
        createPostViewController.currentEvent = self.mEvent;
    }
}


#pragma mark - PostBasicCellDelegate methods
- (void)commentLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"in view controller comment !!!!!#######");
}
- (void)likeLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"in view controller like !!!!!#######");
}

@end
