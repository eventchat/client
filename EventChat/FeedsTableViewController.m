//
//  FeedsTableViewController.m
//  EventChat
//
//  Created by Lyman Cao on 6/4/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "FeedsTableViewController.h"
#import "JsonParser.h"
#import "Constants.h"
#import "Post.h"
#import "User.h"
#import "ItemCell.h"
#import "CreateViewController.h"
#import "UIKit/UIKit.h"

@interface FeedsTableViewController ()

@property (nonatomic, strong) ItemCell *itemCell;

@end

@implementation FeedsTableViewController

static NSString *CellIdentifier = @"ContentCell";

- (ItemCell *) itemCell {
    if (!_itemCell) {
        _itemCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    return _itemCell;
}


// called when a new feed is created
- (IBAction)unwindToFeed:(UIStoryboardSegue *)segue;
{
    CreateViewController *source = [segue sourceViewController];
    Post *item = source.toCreatePost;
    if (item != nil) {
//        NSLog(@"%@ created!", item.mBody);
        [self.allFeeds addObject:item];
        [self.tableView reloadData];
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

    self.allFeeds = [[NSMutableArray alloc] init];
    [self loadInitData];


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
    NSLog(@"%d", [self.allFeeds count]);
    return [self.allFeeds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. Dequeue Cell

    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell:(ItemCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[ItemCell class]]) {
        // Configure the cell...
        Post *post = [self.allFeeds objectAtIndex: indexPath.row];
        cell.userName.text = post.mTitle;
        cell.msgText.text = post.mBody;
//        cell.msgText.text = @"this is a test text message / tweet from jason tao to test if multiple lines still works in our prototype cell";
//        cell.msgText.text = @"this is a short test";
        cell.msgTime.text = post.mCreatedAt;
        //    cell.msgLocation = nil;
        cell.msgLocation.text = @"@Convention Center";
        cell.userImage.image = [UIImage imageNamed:@"placeholder"];
        cell.msgImage.image = [UIImage imageNamed:@"testImage" ];
        
//        CGSize size = {50,50};
//        cell.msgImage.image = [self imageWithImage:[UIImage imageNamed:@"testImage"] scaledToWidth:size];
//        cell.msgImage.frame = CGRectMake(
//                                     cell.msgImage.frame.origin.x,
//                                     cell.msgImage.frame.origin.y, 50, 50);
//        cell.msgImage.contentMode = UIViewContentModeScaleAspectFit;
//        cell.msgImage.clipsToBounds = YES;

//        cell.msgImage = nil;
        
        // test like button
        cell.likePost.tag = indexPath.row;
        [cell.likePost addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.replyPost addTarget:self action:@selector(replyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.morePost addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (IBAction)likeButtonClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"Like"]) {
        // like action takes here
            NSLog(@"likePost clicked!");
        [btn setTitle:@"Dislike" forState:UIControlStateNormal];
    } else {
        // unlike action takes here
        NSLog(@"unlikePost clicked!");
//        btn.titleLabel.text = @"Like";
        [btn setTitle:@"Like" forState:UIControlStateNormal];
    }
    
}

- (IBAction)replyButtonClicked:(id)sender {
    NSLog(@"replyButtonClicked!");
    UIStoryboard *commentStoryboard = [UIStoryboard storyboardWithName:@"Comments" bundle:nil];
    UIViewController *theInitialViewController = [commentStoryboard instantiateViewControllerWithIdentifier:@"myComments"];
    // because the navigation controller for comments is needed
    [(UINavigationController *)self.parentViewController pushViewController: theInitialViewController animated:YES];
//    [self presentModalViewController:theInitialViewController animated:YES];
}

- (IBAction)moreButtonClicked:(id)sender {
    NSLog(@"moreButtonClicked!");
}

//Given a UIImage and a CGSize, this method will return a resized UIImage.
- (UIImage*)imageWithImage:(UIImage*)image
              scaledToWidth:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.itemCell forRowAtIndexPath:indexPath];
    
    // ensure the width of the cell is set to width of the table view when calculating the row height
    self.itemCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.itemCell.bounds));
    [self.itemCell layoutIfNeeded];
    
    CGSize size = [self.itemCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"height: %f, width: %f", size.height, size.width);
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) loadInitData {
    
//    JsonParser *parser = [[JsonParser alloc] init];
//    NSDictionary *dict = [parser parse:[NSURL URLWithString:@"http://eventchat.herokuapp.com/users/538797bb940bf30200bdb649"]];
//    NSString *name = [dict valueForKey:@"name"];
//    NSString *body = dict[@"body"];
    
    
    // mock up data
    User *testUser = [[User alloc] init];
    testUser.mName = @"Lyman Cao";
    testUser.mId = @"538797bb940bf30200bdb649";
    testUser.mEmail = @"lyman@cmu.edu";
    
    Post *testPost = [[Post alloc] init];
    
    testPost.mId = @"818797bb940bf30200bdb649";
    testPost.mTitle = @"hello world";
    testPost.mBody = @"my first post";
    testPost.mAuthor = testUser;
    
    // add the test post
    [self.allFeeds addObject:testPost];
    
//    NSLog(@"%@", name);
//    NSLog(@"%@", body);
}

- (IBAction)CommentClicked:(id)sender{
#warning Potentially incomplete method implementation.
}

@end
