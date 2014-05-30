//
//  FirstViewController.m
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "FirstViewController.h"
#import "JsonParser.h"
#import "Constants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    JsonParser *parser = [[JsonParser alloc] init];
    NSDictionary *dict = [parser parse:[NSURL URLWithString:@"http://eventchat.herokuapp.com/users/538797bb940bf30200bdb649"]];
    NSString *name = [dict valueForKey:@"name"];
    NSLog(@"%@", name);
    NSLog(@"%@", NAME);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
