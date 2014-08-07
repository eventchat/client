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

static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";

static int const MAX_DISTANCE = 100;

@interface EventViewController ()

@end

@implementation EventViewController{
    AppDelegate *appDelegate;
    ECData *appData;
}

@synthesize mEvent;
@synthesize mPosts;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // now currently using 
    [self updateAllPosts:mEvent.mLongitude.doubleValue latitude:mEvent.mLatitude.doubleValue];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSDictionary *data1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Jason Tao", @"author", @"avatar link", @"avatar", @"9:33pm, June 10, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"This meetup is awesome! So many interesting people here. Learnt a lot from them!", @"message", nil];
    
    NSDictionary *data2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"author", @"avatar link", @"avatar", @"00:13pm, June 09, 2014", @"time", @"3", @"likeCnt", @"2", @"commentCnt", @"blahblahblah blahblahblah, la la la", @"message", @"random link to an image", @"image", nil];
    
    NSDictionary *data3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"author", @"avatar link", @"avatar", @"02:00am, June 05, 2014", @"time", @"8", @"likeCnt", @"7", @"commentCnt", @"what is the result for this test?", @"message", @"random image link", @"image", nil];
    
//    cdata = [[NSMutableArray alloc] init];
//    [cdata addObject:data1];
//    [cdata addObject:data2];
//    [cdata addObject:data3];
    
}

- (void)updateAllPosts:(double)longitude latitude:(double)latitude{
    NSString *searchPostsUrl = [NSString stringWithFormat: GET_POST_BY_SEARCH, longitude, latitude, MAX_DISTANCE];
    NSLog(@"search posts url: %@", searchPostsUrl);
    NSURLRequest *allPostsRequest = [NSURLRequest requestWithMethod:@"GET" url:searchPostsUrl parameters:nil];

    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:allPostsRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allPosts = (NSArray *)responseObject;
        mPosts = allPosts;
        NSLog(@"all posts: %lu", [mPosts count]);
        
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
    NSDictionary *postData = [mPosts objectAtIndex:indexPath.row];

    
    cell.authorLabel.text =postData[@"author"][@"name"];
    
    cell.timeLabel.text = [postData valueForKey:@"created_at"];
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu",[((NSArray *)postData[@"liked_by"]) count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu",[((NSArray *)postData[@"comments"]) count]];
    
    cell.messageLabel.text = [postData valueForKey:@"body"];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
}

- (void)configureImageCell:(PostImageCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    NSDictionary *postData = [mPosts objectAtIndex:indexPath.row];
    cell.authorLabel.text =postData[@"author"][@"name"];

    
    cell.timeLabel.text = [postData valueForKey:@"created_at"];
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%lu",[((NSArray *)postData[@"liked_by"]) count]];
    
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%lu",[((NSArray *)postData[@"comments"]) count]];
    
    cell.messageLabel.text = postData[@"body"];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    [cell.messageImageView setImage:nil];
    [cell.messageImageView setImage:[UIImage imageNamed:@"food"]];
    
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *postData = [mPosts objectAtIndex:indexPath.row];
    return ![postData[@"type"] isEqualToString:@"text"];

}

- (PostBasicCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    PostBasicCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier forIndexPath:indexPath];
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

@end
