//
//  ViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/20/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

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
@property (strong, nonatomic) NSDictionary *data;

- (IBAction)loginButtonDidPress:(id)sender;

@end

@implementation ViewController

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

    // Change status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Set delegates
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    // Add listener for textfield change
    [self.emailTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    // now test for join page
//    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"Join" bundle:nil];
//    UIViewController *nextViewController = [nextStoryboard instantiateViewControllerWithIdentifier:@"myJoin"];
//    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nextViewController];
    
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
    NSDictionary *param = @{@"grant_type":@"password",
                            @"username":email,
                            @"password":password,
                            @"client_id":@"750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d",
                            @"client_secret":@"53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
                            };
    NSURLRequest *request = [NSURLRequest postRequest:ECAPILogin
                                           parameters:param];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSError *serializeError;
                                            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializeError];
                                            double delayInSeconds = 1.0f;   // Just for debug
                                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                                                                                                self.loadingView.hidden = YES;
                                                // Get response
                                                self.data = json;
                                                NSString *token = [self.data valueForKeyPath:@"access_token"];
                                                NSLog(@"%@", self.data);

                                                // if logged in
                                                if (token) {
                                                    // do something after logged in
                                                    NSLog(@"I am logged in!");
                                                    // perform segue
                                                    [self performSegueWithIdentifier:@"loginToHomeScene" sender:self];
                                                } else {
                                                    [self doErrorMessage];
                                                }
                                                
                                                
                                            });
                                        }];
    [task resume];
}
@end
