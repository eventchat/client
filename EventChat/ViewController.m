//
//  ViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/20/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//
#import "AFNetworking.h"
#import "ViewController.h"
#import "ApiUtil.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;


- (IBAction)loginButtonDidPress:(id)sender;

@end

@implementation ViewController
@synthesize appDelegate;
@synthesize appData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // initialization
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.data;
    
    // load the cookies
    [ApiUtil loadCookies];
    
    // check logged in or not
    NSURLRequest *loginRequest = [NSURLRequest requestWithMethod:@"GET" url:SESSION parameters:nil];
    AFHTTPRequestOperation *loginOperation = [[AFHTTPRequestOperation alloc] initWithRequest:loginRequest];
    loginOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [loginOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *loginResponse = (NSDictionary *)responseObject;
        if(loginResponse[@"logged_in"] && [loginResponse[@"logged_in"] intValue] == 1){
            NSLog(@"already logged in! should be no login window");
            
            [self pullingMessage];
            // now go to join page
            UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"Join" bundle:nil];
            UIViewController *nextViewController = [nextStoryboard instantiateViewControllerWithIdentifier:@"myJoin"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nextViewController];
        }else{
            NSLog(@"not logged in! should be no login window");
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self doErrorMessage];
    }];
    [loginOperation start];
    
    
    // Change status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Set delegates
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    // Add listener for textfield change
    [self.emailTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    


    
    
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    // Highlight Email TextField
    if ([textField isEqual:self.emailTextField]) {
        NSLog(@"email text field is edited");
        [self.emailTextField setBackground:[UIImage imageNamed:@"input-outline-active"]];
        self.emailImageView.image = [UIImage imageNamed:@"icon-mail-active"];
    } else {
        [self.emailTextField setBackground:[UIImage imageNamed:@"input-outline"]];
        self.emailImageView.image = [UIImage imageNamed:@"icon-mail"];
    }
    
    // Highlight Password TextField
    if ([textField isEqual:self.passwordTextField]) {
        NSLog(@"password text field is edited");
        [self.passwordTextField setBackground:[UIImage imageNamed:@"input-outline-active"]];
        self.passwordImageView.image = [UIImage imageNamed:@"icon-password-active"];
    } else {
        [self.passwordTextField setBackground:[UIImage imageNamed:@"input-outline"]];
        self.passwordImageView.image = [UIImage imageNamed:@"icon-password"];
    }
}

- (void)doErrorMessage {
    // animate with duration
    [UIView animateWithDuration:0.1  animations:^{
        self.loginButton.transform = CGAffineTransformMakeTranslation(10, 0);
    } completion:^(BOOL finished) {
        // step 2
        [UIView animateWithDuration:0.1 animations:^{
            self.loginButton.transform = CGAffineTransformMakeTranslation(-10, 0);
        } completion:^(BOOL finished) {
            // step 3
            [UIView animateWithDuration:0.1 animations:^{
                self.loginButton.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        }];
    }];
    
    // animateWithDuration with damping
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
        // change the size of the dialog view
        [self.dialogView setFrame:CGRectMake(self.dialogView.frame.origin.x, self.dialogView.frame.origin.y, self.dialogView.frame.size.width, 320)];
    } completion:^(BOOL finished) {}];
}

-(void)textFieldDidChange:(UITextField *) textField {
    if (textField.text.length > 20) {
        self.emailImageView.hidden = YES;
    } else {
        self.emailImageView.hidden = NO;
    }
}


- (IBAction)loginButtonDidPress:(id)sender {

    // hide loadingView
    self.loadingView.hidden = NO;
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *param = @{@"name":email,
                            @"password":password};
    NSURLRequest *request = [NSURLRequest postRequest: SESSION parameters:param];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    self.loadingView.hidden = YES;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // logged in successfully
        
        // get response data
        NSDictionary *userDataDict = (NSDictionary *)responseObject;
        NSLog(@"%@", userDataDict);
        
        NSLog(@"User Data is: id - %@, email - %@, info - %@, name - %@, avatar - %@",
              [userDataDict objectForKey:@"id"],
              [userDataDict objectForKey:@"email"],
              [userDataDict objectForKey:@"info"],
              [userDataDict objectForKey:@"name"],
              [userDataDict objectForKey:@"avatar_url"]);
        
        User *userData = [[User alloc] initWithId:[userDataDict objectForKey:@"id"] withEmail:[userDataDict objectForKey:@"email"] withInfo:[userDataDict objectForKey:@"info"] withName:[userDataDict objectForKey:@"name"] withAvatarUrl:[userDataDict objectForKey:@"avatar_url"]];
        // do something after logged in
        NSLog(@"I am logged in!");
        [appData setUser:userData];

        // save the cookie
        [ApiUtil saveCookies];
        
        [self pullingMessage];
        NSLog(@"passed send get request");
        // perform segue
        [self performSegueWithIdentifier:@"loginToHomeScene" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // fail to log in
        [self doErrorMessage];
    }];
    [operation start];
}

-(void) pullingMessage {
    // start checking incoming message
    NSURLRequest *messageRequest = [NSURLRequest getRequest: CHAT parameters:nil];
    
    AFHTTPRequestOperation *chat_operation = [[AFHTTPRequestOperation alloc] initWithRequest:messageRequest];
    chat_operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [chat_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"successfully get chat info");
        NSArray *dataArray = [[NSArray alloc] initWithArray:(NSArray *) responseObject];
        NSLog(@"%@", dataArray);
        
        // package received messageArray
        NSMutableArray *messageArray = [[NSMutableArray alloc] init];
        for (NSDictionary *data in dataArray) {
            
        }
        
        // add into conversation
        [appData addConversationWithReceivedMessageArray:messageArray];
        
        
        [self pullingMessage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get chat info");
        [self pullingMessage];
    }];
    [chat_operation start];
}
@end


