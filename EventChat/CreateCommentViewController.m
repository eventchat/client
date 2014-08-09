//
//  CreateCommentViewController.m
//  EventChat
//
//  Created by Lyman Cao on 6/13/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CreateCommentViewController.h"

@interface CreateCommentViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CreateCommentViewController


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) {
        return;
    }
    if (self.textView.text.length > 0) {
        self.toCreateComment = [[Comment alloc] init];
        self.toCreateComment.mBody = self.textView.text;     
    }
    
}


@end
