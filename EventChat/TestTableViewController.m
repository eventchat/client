//
//  TestTableViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/27/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "TestTableViewController.h"
#import "PostCell.h"

@interface TestTableViewController ()

//@property (nonatomic, strong) NSMutableArray *data;
@end

NSMutableArray *cdata;

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
    NSDictionary *data1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Jason Tao", @"author", @"avatar link", @"avatar", @"9:33pm, June 10, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"this is a test message, a short one", @"message", @"this is a test image, a random one", @"image", nil];
    
    NSDictionary *data2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"author", @"avatar link", @"avatar", @"00:13pm, June 09, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"blahblahblah blahblahblah, la la la", @"message", @"random link to an image", @"image", nil];
    
    NSDictionary *data3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"author", @"avatar link", @"avatar", @"02:00am, June 05, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"what is the result for this test?", @"message", @"random image link", @"image", nil];

    cdata = [[NSMutableArray alloc] init];
    [cdata addObject:data1];
    [cdata addObject:data2];
    [cdata addObject:data3];
    
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
    return [cdata count];
}

- (PostCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"postCell";
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
//    [self configureCell:cell forIndexPath:indexPath];
//    CGFloat height  = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return 200;
    
}

#pragma mark - private methods

- (void)configureCell: (PostCell *)cell forIndexPath: (NSIndexPath *)indexPath {
    // Configure the cell...
    NSDictionary *postData = [cdata objectAtIndex:indexPath.row];
    
    NSLog(@"%@", [postData valueForKey:@"author"]);
    
    cell.authorLabel.text =[postData valueForKey:@"author"];
    
    cell.timeLabel.text = [postData valueForKey:@"time"];
    
    cell.likeCountLabel.text = [postData valueForKey:@"likeCnt"];
    
    cell.commentCountLabel.text = [postData valueForKey:@"commentCnt"];
    
    cell.messageLabel.text = [postData valueForKey:@"message"];
    
    cell.avatarImageView.image = [UIImage imageNamed:@"placeholder"];
    
    cell.picImageView.image = Nil;
    
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
