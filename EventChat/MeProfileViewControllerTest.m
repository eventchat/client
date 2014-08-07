//
//  ProfileViewController.m
//  EventChat
//
//  Created by Lyman Cao on 7/11/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "MeProfileViewControllerTest.h"
#import "PostBasicCell.h"
#import "PostImageCell.h"
#import "ApiUtil.h"
@interface MeProfileViewControllerTest ()

@end

NSMutableArray *mData;
static NSString * const PostBasicCellIdentifier = @"PostBasicCell";
static NSString * const PostImageCellIdentifier = @"PostImageCell";


@implementation MeProfileViewControllerTest
@synthesize mUserPostTableView;
@synthesize mAppDelegate;
@synthesize mAppData;


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
    NSDictionary *data1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Jason Tao", @"author", @"avatar link", @"avatar", @"9:33pm, June 10, 2014", @"time", @"5", @"likeCnt", @"4", @"commentCnt", @"This meetup is awesome! So many interesting people here. Learnt a lot from them!", @"message", nil];
    
    NSDictionary *data2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Lyman Cao", @"author", @"avatar link", @"avatar", @"00:13pm, June 09, 2014", @"time", @"3", @"likeCnt", @"2", @"commentCnt", @"blahblahblah blahblahblah, la la la", @"message", @"random link to an image", @"image", nil];
    
    NSDictionary *data3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Xiaolei Jin", @"author", @"avatar link", @"avatar", @"02:00am, June 05, 2014", @"time", @"8", @"likeCnt", @"7", @"commentCnt", @"what is the result for this test?", @"message", @"random image link", @"image", nil];
    
    
    mData = [[NSMutableArray alloc] init];
    [mData addObject:data1];
    [mData addObject:data2];
    [mData addObject:data3];
    
    
    UIColor *color = [ApiUtil colorWithHexString:@"FDA10F"];
    self.view.backgroundColor = color;
//    self.mUserPostTableView.backgroundView = nil;
    
    // Disable navigation bar shadow
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"header_line"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"the total count is :%lu", (unsigned long)[mData count]);
    return [mData count];
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
    for (NSIndexPath *indexPath in [self.mUserPostTableView indexPathsForSelectedRows]) {
        [self.mUserPostTableView deselectRowAtIndexPath:indexPath animated:NO];
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
    PostBasicCell *cell = [self.mUserPostTableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PostBasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostBasicCellIdentifier];
        
        cell.backgroundColor = self.mUserPostTableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.dataSource = self.mUserPostTableView;
//        cell.delegate = self.mUserPostTableView;
    }
    [self configureBasicCell:cell forIndexPath:indexPath];
    return cell;
}

- (PostImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCell *cell = [self.mUserPostTableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PostImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostImageCellIdentifier];
        
        cell.backgroundColor = self.mUserPostTableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataSource = self.mUserPostTableView;
        cell.delegate = self.mUserPostTableView;
    }
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static PostBasicCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.mUserPostTableView dequeueReusableCellWithIdentifier:PostBasicCellIdentifier];
    });
    
    [self configureBasicCell:sizingCell forIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell] + 1;
}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath {
    static PostImageCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.mUserPostTableView dequeueReusableCellWithIdentifier:PostImageCellIdentifier];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
