//
//  SecondViewController.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateViewController : UIViewController

// called when a new feed is created
- (IBAction)unwindToFeed:(UIStoryboardSegue *)segue;

@end
