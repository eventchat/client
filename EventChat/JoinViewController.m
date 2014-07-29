//
//  JoinViewController.m
//  EventChat
//
//  Created by Lyman Cao on 7/28/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController ()

@end

static NSInteger const SESSION_TIMEOUT = 3; // 5 secs or give up
static NSInteger unlockCount = 0;
static NSTimeInterval elapsedTime;
static NSInteger prevNumber = -1;


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
    patterns = [[NSDictionary alloc] initWithObjectsAndKeys:@"53d6d5a7da0e0f0200e69de6", @"1234", @"53d6d749da0e0f0200e69de7", @"4321", nil];
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
    for (NSString *key in patterns) {
        if (currentPattern) {
            break;
        }else{
            currentPattern = [NSString stringWithString:key];            
        }

        NSInteger pos = [currentPattern rangeOfString:[NSString stringWithFormat:@"%ld",(long)buttonTag]].location;
        if ((prevNumber == -1 && buttonTag == [[currentPattern substringToIndex:1] integerValue]) || [currentPattern rangeOfString:[NSString stringWithFormat:@"%ld",(long)prevNumber]].location == pos - 1) {
            
            NSLog(@"unlock: %ld, prevNumber: %ld, buttonTag: %ld\n", (long)unlockCount, (long)prevNumber, (long)buttonTag);
            prevNumber = buttonTag;
            unlockCount++;
            break;
        }else{
            [self resetButtons];
            continue;
        }
    }
    
    
    if (unlockCount == 4 && currentPattern) {
        NSLog(@"current pattern: %@, key: %@", currentPattern, [patterns objectForKey:currentPattern] );
        [self jumpToEventPage:[patterns objectForKey:currentPattern]];
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

- (void) jumpToEventPage:(NSString *)myEvent{
    // TODO: choose the event
    
    // begin the jump
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UIViewController *nextViewController = [nextStoryboard instantiateViewControllerWithIdentifier:@"myTabs"];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nextViewController];
}

@end
