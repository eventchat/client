//
//  TweetCell.h
//  EventChat
//
//  Created by Jianchen Tao on 6/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@property (strong, nonatomic) IBOutlet UIImageView *msgImage;

@property (strong, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) IBOutlet UILabel *msgTime;

@property (strong, nonatomic) IBOutlet UILabel *msgText;

@property (strong, nonatomic) IBOutlet UILabel *msgLocation;

@property (strong, nonatomic) IBOutlet UIButton *replyPost;

@property (strong, nonatomic) IBOutlet UIButton *forwardPost;

@property (strong, nonatomic) IBOutlet UIButton *likePost;

@property (strong, nonatomic) IBOutlet UIButton *followUser;

@end
