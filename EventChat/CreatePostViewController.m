//
//  CreatePostViewController.m
//  EventChat
//
//  Created by Lyman Cao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CreatePostViewController.h"
#import "Post.h"
#import "AppDelegate.h"
#import "ECData.h"
#import "ApiUtil.h"
#import "AFNetworking.h"

@interface CreatePostViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

static NSString * const DEFAULT_TITLE = @"New Post";

@implementation CreatePostViewController{
    AppDelegate *appDelegate;
    ECData *appData;
}
@synthesize toCreatePost;
@synthesize currentEvent;

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.mData;
    
    NSLog(@"in createPost: what is my event?%@", currentEvent);
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) {
        return;
    }
    NSLog(@"!!current Event: %@", currentEvent);
    if (self.textView.text.length > 0) {
        NSString *currentTimestamp = [ApiUtil generateTimestamp];
        NSLog(@"in create Post timestamp: %@",currentTimestamp);
        self.toCreatePost = [[Post alloc] initWithId:appData.mId withTitle:DEFAULT_TITLE withAuthor:appData.mUser withBody:self.textView.text withPic:nil withCreatedAt:currentTimestamp withComments:[NSMutableArray array] withLikes:[NSMutableArray array] withType:@"text" withEvent:currentEvent];
        [self sendPostToServer];
    }
}

- (void) sendPostToServer{
    NSLog(@"\n\ntoSendPost: %@", toCreatePost);
    
    NSString *createPost = [NSString stringWithString: CREATE_POST];
    NSDictionary *params = @{@"title":toCreatePost.mTitle,
                            @"type":toCreatePost.mType,
                            @"body":toCreatePost.mBody,
                            @"event_id":toCreatePost.mEvent.mId};
    

    NSURLRequest *createPostRequest = [NSURLRequest requestWithMethod:@"POST" url:createPost parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:createPostRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"create post response %@", (NSDictionary *)responseObject);
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // fail to log in
         NSLog(@"create post err: %@", error);
     }];
    [operation start];
}

@end
