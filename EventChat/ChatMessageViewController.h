//
//  ChatMessageViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)IBOutlet UITableView *messageTable;
@property (nonatomic, strong)IBOutlet UIButton *sendMessage;
@property (nonatomic, strong)IBOutlet UIButton *sendImage;
@property (nonatomic, strong)IBOutlet UITextField *textField;

@end
