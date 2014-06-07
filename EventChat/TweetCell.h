//
//  TweetCell.h
//  EventChat
//
//  Created by Jianchen Tao on 6/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@property (strong, nonatomic) IBOutlet UIImageView *tweetImage;

@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;

@property (strong, nonatomic) IBOutlet UILabel *tweetText;

@property (strong, nonatomic) IBOutlet UILabel *tweetTime;

@property (strong, nonatomic) IBOutlet UILabel *tweetLocation;

@end
