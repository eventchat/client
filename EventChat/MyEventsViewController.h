//
//  MyEventsViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/23/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEventsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *attendHostSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@end
