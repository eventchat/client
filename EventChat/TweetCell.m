//
//  TweetCell.m
//  EventChat
//
//  Created by Jianchen Tao on 6/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

@synthesize tweetImage = _tweetImage;

@synthesize userImage = _userImage;

@synthesize tweetLabel = _tweetLabel;

@synthesize tweetText = _tweetText;

@synthesize tweetTime = _tweetTime;

@synthesize tweetLocation = _tweetLocation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
