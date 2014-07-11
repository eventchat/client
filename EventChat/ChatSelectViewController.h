//
//  ChatSelectViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatSelectViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)IBOutlet UITableView *chatterTable;

@end
