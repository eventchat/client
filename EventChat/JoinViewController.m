//
//  JoinViewController.m
//  EventChat
//
//  Created by Lyman Cao on 7/28/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "JoinViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "ApiUtil.h"
#import "EventViewController.h"
#import "Event.h"

@interface JoinViewController ()

@end

static NSInteger const SESSION_TIMEOUT = 3; // 5 secs or give up
static NSInteger unlockCount = 0;
static NSTimeInterval elapsedTime;
static NSInteger prevNumber = -1;

// two predefined events
static NSString * const EVENT_A = @"53d6d5a7da0e0f0200e69de6";
static NSString * const EVENT_B = @"53d6d749da0e0f0200e69de7";

@implementation JoinViewController{
    // mock the unlock pattern
    NSDictionary *patterns;
    NSString *currentPattern;
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
    
    
    // load the pattern to join event
    NSLog(@"join page is loaded");
    [_buttonA addTarget:self action:@selector(buttonAClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonB addTarget:self action:@selector(buttonBClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonC addTarget:self action:@selector(buttonCClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonD addTarget:self action:@selector(buttonDClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // now having the two predefined patterns
    patterns = [[NSDictionary alloc] initWithObjectsAndKeys:EVENT_A, @"1234", EVENT_B, @"4321", nil];
    elapsedTime = CFAbsoluteTimeGetCurrent();
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

- (void) resetButtons{
    unlockCount = 0;
    prevNumber = -1;
    currentPattern = nil;
}
- (void) parsePattern:(id)sender{
    UIButton * pressedButton = (UIButton *)sender;
    
    NSInteger buttonTag = pressedButton.tag;
    // set the time
    NSTimeInterval oldTime = elapsedTime;
    elapsedTime = CFAbsoluteTimeGetCurrent();

    if (elapsedTime > oldTime + SESSION_TIMEOUT ) {
        // timeout, reset everything
        [self resetButtons];
    }
    // same button pressed twice
    if (prevNumber == buttonTag) {
        return;
    }
    if (!currentPattern) {
        for (NSString *key in patterns) {
            currentPattern = [NSString stringWithString:key];
            
            BOOL breakFlag = [self verifyPattern:buttonTag];
            if (breakFlag) {
                break;
            }
        }
    }else{
        [self verifyPattern:buttonTag];
    }
    
    
    if (unlockCount == 4 && currentPattern) {
        NSLog(@"current pattern: %@, key: %@", currentPattern, [patterns objectForKey:currentPattern] );
        [self jumpToEventPage:[patterns objectForKey:currentPattern]];
    }
}

- (BOOL) verifyPattern:(NSInteger) buttonTag{
    NSInteger pos = [currentPattern rangeOfString:[NSString stringWithFormat:@"%ld",(long)buttonTag]].location;
    if ((prevNumber == -1 && buttonTag == [[currentPattern substringToIndex:1] integerValue]) || [currentPattern rangeOfString:[NSString stringWithFormat:@"%ld",(long)prevNumber]].location == pos - 1) {
        
        NSLog(@"unlock: %ld, prevNumber: %ld, buttonTag: %ld\n", (long)unlockCount, (long)prevNumber, (long)buttonTag);
        prevNumber = buttonTag;
        unlockCount++;
        return YES;
    }else{
        [self resetButtons];
        return NO;
    }
}

- (IBAction)buttonAClicked:(id)sender{
    [self parsePattern:sender];
}

- (IBAction)buttonBClicked:(id)sender{
    [self parsePattern:sender];
}

- (IBAction)buttonCClicked:(id)sender{
    [self parsePattern:sender];
}

- (IBAction)buttonDClicked:(id)sender{
    [self parsePattern:sender];
}

- (void) jumpToEventPage:(NSString *)eventId{
    NSURLRequest *request = [NSURLRequest postRequest: [NSString stringWithFormat:JOIN_EVENT, eventId]  parameters:nil];
    
            NSLog(@"%@",[NSHTTPCookieStorage sharedHTTPCookieStorage]);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // do something after logged in
        NSLog(@"I have joined the event %@",JOIN_EVENT );
        // begin the jump
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UITabBarController *nextViewController = [nextStoryboard instantiateViewControllerWithIdentifier:@"myTabs"];
        nextViewController.selectedViewController = [nextViewController.viewControllers objectAtIndex:1];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nextViewController];
        
        // the jump to event

        [self getSingleEvent:eventId currentViewController:[[[[UIApplication sharedApplication] delegate] window] rootViewController]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"join event failed");
                
        NSLog(@"failed %@",error );
    }];
    [operation start];
}
- (void)getSingleEvent:(NSString *)eventId currentViewController:(UIViewController*)currentViewController{

    NSURLRequest *request = [NSURLRequest getRequest:[NSString stringWithFormat: GET_EVENT_BY_EVENT_ID, eventId]  parameters:nil];
    
    NSLog(@"single event request %@", request);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        // begin the jump
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        EventViewController *singleEventViewController = [nextStoryboard instantiateViewControllerWithIdentifier:@"singleEvent"];
        singleEventViewController.mEvent = [Event createEventwithDictionary:(NSDictionary *)responseObject];
        
        [(UINavigationController *)((UITabBarController *)currentViewController).selectedViewController pushViewController: singleEventViewController animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"failed %@",error );
    }];
    [operation start];
}
@end
