//
//  TestTableViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/27/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "TestTableViewController.h"
#import "PostBasicCell.h"
#import "PostImageCell.h"

static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";

NSMutableArray *mData;

@interface TestTableViewController ()

//@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TestTableViewController


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSDictionary *data1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Jason Tao", @"author", @"avatar link", @"avatar", @"9:33pm, June 10, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"This meetup is awesome! So many interesting people here. Learnt a lot from them!", @"message", nil];
    
    NSDictionary *data2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"author", @"avatar link", @"avatar", @"00:13pm, June 09, 2014", @"time", @"3", @"likeCnt", @"2", @"commentCnt", @"blahblahblah blahblahblah, la la la", @"message", @"random link to an image", @"image", nil];
    
    NSDictionary *data3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"author", @"avatar link", @"avatar", @"02:00am, June 05, 2014", @"time", @"8", @"likeCnt", @"7", @"commentCnt", @"what is the result for this test?", @"message", @"random image link", @"image", nil];

    mData = [[NSMutableArray alloc] init];
    [mData addObject:data1];
    [mData addObject:data2];
    [mData addObject:data3];
    
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
    return [mData count];
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
    if ([self hasImageAtIndexPath:indexPath]) {
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
    NSDictionary *postData = [mData objectAtIndex:indexPath.row];
    
    NSLog(@"%@", [postData valueForKey:@"author"]);
    
    cell.authorLabel.text =[postData valueForKey:@"author"];
    
    cell.timeLabel.text = [postData valueForKey:@"time"];
    
    cell.likeCountLabel.text = [postData valueForKey:@"likeCnt"];
    
    cell.commentCountLabel.text = [postData valueForKey:@"commentCnt"];
    
    cell.messageLabel.text = [postData valueForKey:@"message"];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
}

- (void)configureImageCell:(PostImageCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    NSDictionary *postData = [mData objectAtIndex:indexPath.row];
    cell.authorLabel.text =[postData valueForKey:@"author"];
    
    cell.timeLabel.text = [postData valueForKey:@"time"];
    
    cell.likeCountLabel.text = [postData valueForKey:@"likeCnt"];
    
    cell.commentCountLabel.text = [postData valueForKey:@"commentCnt"];
    
    cell.messageLabel.text = [postData valueForKey:@"message"];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    [cell.messageImageView setImage:nil];
    [cell.messageImageView setImage:[UIImage imageNamed:@"food"]];
    
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *postData = [mData objectAtIndex:indexPath.row];
    NSString *postImageUrl = [postData valueForKey:@"image"];
    return postImageUrl != nil;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
