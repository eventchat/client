//
//  CreateCommentViewController.m
//  EventChat
//
//  Created by Lyman Cao on 6/13/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CreateCommentViewController.h"

@interface CreateCommentViewController ()

@end

@implementation CreateCommentViewController

// called when a new feed is created
- (IBAction)unwindToPost:(UIStoryboardSegue *)segue;
{
//    CreateCommentViewController *source = [segue sourceViewController];
//    Post *item = source.toCreatePost;
//    if (item != nil) {
//        //        NSLog(@"%@ created!", item.mBody);
//        [self.allFeeds addObject:item];
//        [self.tableView reloadData];
//    }
}


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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
