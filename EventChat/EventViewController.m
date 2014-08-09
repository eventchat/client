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
#import "CommentsTableViewController.h"

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
        [self updateAllPosts];
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
    [self updateAllPosts];
    
    // now update the event detail
    [self updateEventDetail];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAllPosts) name:@"NewCommentNotification" object:nil];
    
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

- (void)updateAllPosts{
    NSString *getAllPostsUrl = [NSString stringWithFormat: GET_POSTS_BY_EVENT_ID, mEvent.mId];
    NSURLRequest *allPostsRequest = [NSURLRequest requestWithMethod:@"GET" url:getAllPostsUrl parameters:nil];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:allPostsRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allPostsDict = (NSArray *)responseObject;
        // init mPosts
        mPosts = [[NSMutableArray alloc] init];
        
        for(NSDictionary *singlePostDict in [allPostsDict reverseObjectEnumerator]){
            [mPosts addObject:[Post createPostWithData:singlePostDict]];
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
    
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    cell.messageImageView.image = [UIImage imageNamed:@"food"];
    
    NSURL *imageURL = [NSURL URLWithString:[ApiUtil detectUrlInString:currentPost.mBody]];
    if (imageURL != (id)[NSNull null]) {
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
    
    // add delegate
    cell.delegate = self;
    
    [self configureBasicCell:cell forIndexPath:indexPath];
    return cell;
}

- (PostImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier forIndexPath:indexPath];

    // add delegate
    cell.delegate = self;
    
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
        destViewController.mAppUser = appData.mUser;
        destViewController.mAppData = appData;
    }else if([segue.identifier isEqualToString:@"composePost"]){
        
        CreatePostViewController *createPostViewController = (CreatePostViewController *)[[segue destinationViewController] topViewController];
        createPostViewController.currentEvent = self.mEvent;
    }
}


#pragma mark - PostBasicCellDelegate methods
- (void)commentLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    
    UIStoryboard *commentStoryboard = [UIStoryboard storyboardWithName:@"Comments" bundle:nil];
    CommentsTableViewController *commentsViewController = [commentStoryboard instantiateViewControllerWithIdentifier:@"myComments"];
    commentsViewController.allComments = currentPost.mComments;
    commentsViewController.currentPost = currentPost;
    commentsViewController.currentUser = appData.mUser;
    
    [(UINavigationController *)self.parentViewController pushViewController: commentsViewController animated:YES];
    // because the navigation controller for comments is needed
    
}
- (void)likeLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath  likeStatus:(BOOL)liked{
    
    Post *currentPost = [mPosts objectAtIndex:indexPath.row];
    NSString *likeUrl = [NSString stringWithFormat:LIKE_POST, currentPost.mId];
    NSURLRequest *likeRequest;
    if (liked) {
        likeRequest = [NSURLRequest requestWithMethod:@"DELETE" url:likeUrl parameters:nil];
    }else{
        likeRequest = [NSURLRequest requestWithMethod:@"POST" url:likeUrl parameters:nil];
    }
    NSLog(@"####### show likeRequest %@", likeRequest);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:likeRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"##### like succeed!%@", (NSDictionary *)responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"##### like error %@",error);
    }];
    [operation start];
}

@end
