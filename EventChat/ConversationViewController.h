//
//  ChatSelectViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ConversationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)IBOutlet UITableView *mConversationTable;
@property AppDelegate *mAppDelegate;
@property ECData *mAppData;
@property NSMutableDictionary *mConversationDict;
@end
