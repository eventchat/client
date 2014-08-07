//
//  ChatMessageViewController.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ECData.h"
#import "Conversation.h"

@interface ChatMessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)IBOutlet UITableView *mMessageTable;
@property (nonatomic, strong)IBOutlet UIButton *mSendMessage;
@property (nonatomic, strong)IBOutlet UIButton *mSendImage;
@property (nonatomic, strong)IBOutlet UITextField *mTextField;

@property Conversation *mConversation;
@property User *mAppUser;
@end
