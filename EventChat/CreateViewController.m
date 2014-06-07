//
//  SecondViewController.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CreateViewController.h"
#import "Post.h"
#import "User.h"

@interface CreateViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;


@end

@implementation CreateViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) {
        return;
    }
    if (self.textView.text.length > 0) {
        self.toCreatePost = [[Post alloc] init];
        
        // fake id, to be implemented
        self.toCreatePost.mId = @"test123";
        // fake author, to be implemented
        User *testUser = [[User alloc] init];
        testUser.mName = @"LymanC";
        testUser.mId = @"538797bb940bf30200bdb649";
        testUser.mEmail = @"helloworld@test.com";
        self.toCreatePost.mAuthor = testUser;
        self.toCreatePost.mTitle = @"test post";
        // end of fake data
        
        self.toCreatePost.mBody = self.textView.text;
        self.toCreatePost.mCreatedAt =[self generateTimestamp];
    }
}

- (NSString *) generateTimestamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSDate *now = [NSDate date];
    NSString *currentTimestamp = [dateFormatter stringFromDate:now];
    return currentTimestamp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
